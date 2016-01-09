//
//  JYCountDownView.h
//  自定义倒计时
//
//  Created by qingyun on 16/1/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYCountDownView : UIView

/**
 *  结束的回调
 */
@property (nonatomic, copy) void (^TimerStopComplete)();

/**
 *  加载xib文件，返回对应View
 */
+ (instancetype)loadCountDownView;

/**
 *  根据指定结束时间开始倒计时
 *
 *  @param endDate NSDate格式的结束时间
 */
- (void)countDownViewWithEndData:(NSDate *)endDate;

/**
 *  根据指定结束时间开始倒计时
 *
 *  @param endStr NSString格式的结束时间
 */
- (void)countDownViewWithEndString:(NSString *)endStr;

@end
