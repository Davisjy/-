//
//  ViewController.m
//  自定义倒计时
//
//  Created by qingyun on 16/1/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "JYCountDownView.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JYCountDownView *view = [JYCountDownView loadCountDownView];
    view.center = self.view.center;
    
    NSDate *endDate = [NSDate dateWithTimeIntervalSinceNow:10];
    [view countDownViewWithEndData:endDate];
    
//    NSString *endStr = @"2016-01-15";
//    [view countDownViewWithEndString:endStr];
    
    // 结束的回调
    view.TimerStopComplete = ^{
        NSLog(@"哈哈，倒计时结束了哎😁");
    };
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
