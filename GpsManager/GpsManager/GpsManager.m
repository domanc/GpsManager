//
//  GpsManager.m
//  GpsManager
//
//  Created by Doman on 17/3/28.
//  Copyright © 2017年 doman. All rights reserved.
//

#import "GpsManager.h"

@interface GpsManager()

@property(nonatomic, strong)CLGeocoder *geocoder;

@end

@implementation GpsManager

+ (BOOL)cdm_isLocationServiceOpen
{
    if ([ CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return NO;
    } else
        return YES;
}

-(CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

+ (GpsManager *)sharedGpsManager
{
    static GpsManager *instance = nil;
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        
        instance = [[GpsManager alloc] init];
    });
    
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        // 打开定位 然后得到数据
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
        //_manager.desiredAccuracy = kCLLocationAccuracyBest;
        _manager.desiredAccuracy = kCLLocationAccuracyKilometer;
        _manager.distanceFilter = 1000;
        
        if ([_manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_manager requestWhenInUseAuthorization];
            //[_manager requestAlwaysAuthorization];
        }
        
    }
    return self;
}

- (void)cdm_getGps
{
    // 停止上一次的
    //    [_manager stopUpdatingLocation];
    // 开始新的数据定位
    [_manager startUpdatingLocation];
}


- (void)cdm_stop {
    
    [_manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
   // NSLog(@"%zd",location.coordinate);
    
    // 反向地理编译出地址信息
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error)
        {
            if ([placemarks count] > 0) {
                
                CLPlacemark *placemark = [placemarks firstObject];
               // NSLog(@"placemark-----%@",placemark);
                NSLog(@"placemark.city-----%@",placemark.locality);
                
                // 获取城市
                NSString *city = placemark.locality;
                if (!city.length) {
                    // 6
                    [GpsManager sharedGpsManager].cityName = @"北京";
                }
                
                else {
                    [GpsManager sharedGpsManager].cityName = city;
                }
                
                
              //  NSLog(@"self.cityName---%@",[GpsManager sharedGpsManager].cityName);
                
            } else if ([placemarks count] == 0) {
                
                
                [GpsManager sharedGpsManager].cityName = @"北京";
            }
        }
        else
        {
            [GpsManager sharedGpsManager].cityName = @"北京";
        }
        
        //        [[CKGpsManager sharedGpsManager] stop];
        //1.这种是在需要的时候用，和下面NSUserDefaults 看自己的需求来用.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GPS" object:nil userInfo:@{@"cityName":[GpsManager sharedGpsManager].cityName}];
        
        NSString *tmpCity = [GpsManager sharedGpsManager].cityName;
        tmpCity = [tmpCity stringByReplacingOccurrencesOfString:@"市" withString:@""];
        
        //保存当前位置信息
        if (!tmpCity.length) {
            tmpCity = @"北京";
        }
        //2.这种是在首页或者启动的时候用.
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:tmpCity forKey:@"CurrentCityKey"];
        [defaults synchronize];
    }];
    
    [self.manager stopUpdatingLocation];
    
}


@end
