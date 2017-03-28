//
//  GpsManager.h
//  GpsManager
//
//  Created by Doman on 17/3/28.
//  Copyright © 2017年 doman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GpsManager : NSObject<CLLocationManagerDelegate>

@property (nonatomic,strong)CLLocationManager *manager;

@property (nonatomic,copy)NSString *cityName;


+ (GpsManager *)sharedGpsManager;

+ (BOOL)cdm_isLocationServiceOpen;

- (void)cdm_getGps;
- (void)cdm_stop;


@end
