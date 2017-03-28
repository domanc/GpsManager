//
//  ViewController.m
//  GpsManager
//
//  Created by Doman on 17/3/28.
//  Copyright © 2017年 doman. All rights reserved.
//

#import "ViewController.h"
#import "GpsManager.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[GpsManager sharedGpsManager] cdm_getGps];
    CGFloat width = self.view.bounds.size.width;
    
    UIButton *weChatBtn = [[UIButton alloc] initWithFrame:CGRectMake((width - 100) / 2, 200, 100, 40)];
    [weChatBtn setTitle:@"NEXT" forState:UIControlStateNormal];
    weChatBtn.backgroundColor = [UIColor redColor];
    [weChatBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weChatBtn];


    // Do any additional setup after loading the view, typically from a nib.
}

- (void)next
{
    TestViewController *test = [[TestViewController alloc] init];
    
    [self presentViewController:test animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
