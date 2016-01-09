//
//  JYCountDownView.m
//  自定义倒计时
//
//  Created by qingyun on 16/1/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "JYCountDownView.h"

@interface JYCountDownView ()
{
    dispatch_source_t _timer;
}
/** 天 */
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
/** 小时 */
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
/** 分钟 */
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
/** 秒 */
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@end

@implementation JYCountDownView

+ (instancetype)loadCountDownView
{
    // 从xib加载视图
    return [[NSBundle mainBundle] loadNibNamed:@"JYCountDownView" owner:self options:nil][0];
}

/**
 *  根据指定时间间隔开始倒计时
 */
- (void)fireWithTimeIntervar:(NSTimeInterval)timerInterval
{
    if (_timer == nil) {
        __block int timeout = timerInterval; //倒计时时间
        
        if (timeout != 0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout <= 0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.dayLabel.text = @"";
                        self.hourLabel.text = @"00";
                        self.minuteLabel.text = @"00";
                        self.secondLabel.text = @"00";
                    });
                    // 结束的回调
                    if (_TimerStopComplete) {
                        _TimerStopComplete();
                    }
                }else{
                    int days = (int)(timeout/(3600*24));
                    if (days == 0) {
                        self.dayLabel.text = @"";
                    }
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (days == 0) {
                            self.dayLabel.text = @"0天";
                        }else {
                            self.dayLabel.text = [NSString stringWithFormat:@"%d天",days];
                        }
                        if (hours < 10) {
                            self.hourLabel.text = [NSString stringWithFormat:@"0%d",hours];
                        }else {
                            self.hourLabel.text = [NSString stringWithFormat:@"%d",hours];
                        }
                        if (minute < 10) {
                            self.minuteLabel.text = [NSString stringWithFormat:@"0%d",minute];
                        }else{
                            self.minuteLabel.text = [NSString stringWithFormat:@"%d",minute];
                        }
                        if (second < 10) {
                            self.secondLabel.text = [NSString stringWithFormat:@"0%d",second];
                        }else {
                            self.secondLabel.text = [NSString stringWithFormat:@"%d",second];
                        }
                        
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}

#pragma mark 根据NSString格式的结束时间倒计时
- (void)countDownViewWithEndString:(NSString *)endStr
{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *endDate = [formatter dateFromString:endStr];
    NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:now];
    
    [self fireWithTimeIntervar:timeInterval];
}

#pragma mark 根据NSDate格式的结束时间倒计时
- (void)countDownViewWithEndData:(NSDate *)endDate
{
    NSDate *now = [NSDate date];
    NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:now];
    
    [self fireWithTimeIntervar:timeInterval];
}


@end
