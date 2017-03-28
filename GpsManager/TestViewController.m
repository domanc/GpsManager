//
//  TestViewController.m
//  GpsManager
//
//  Created by Doman on 17/3/28.
//  Copyright © 2017年 doman. All rights reserved.
//

#import "TestViewController.h"
#import "GpsManager.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.这种直接加入直接在首页的时候就已经获取定位拿到当前城市，在你要用的地方直接取.
    NSLog(@"gps----%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentCityKey"]);
    self.view.backgroundColor = [UIColor orangeColor];
    
    //2.有一种情况是某些APP当你用到的定位的时候才回去提示用户，获取当前城市，可以用下面这种.
    [[GpsManager sharedGpsManager] cdm_getGps];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getGpsMsg:) name:@"GPS" object:nil];
    // Do any additional setup after loading the view.
}

- (void)getGpsMsg:(NSNotification *)noti
{
    NSLog(@"%@",noti.userInfo[@"cityName"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
