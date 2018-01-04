//
//  NSTimer+BlockSupport.m
//  Buy
//
//  Created by BinghongLee on 16/3/5.
//  Copyright © 2016年 KuGou. All rights reserved.
//

#import "NSTimer+BlockSupport.h"

@implementation NSTimer (BlockSupport)

+ (NSTimer *)bs_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)())block repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self selector:@selector(blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (NSTimer *)bs_timerWithTimeInterval:(NSTimeInterval)interval block:(void (^)())block repeats:(BOOL)repeats
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(blockInvoke:) userInfo:[block copy] repeats:repeats];
    return timer;
}

+ (void)blockInvoke:(NSTimer *)timer
{
    void(^block)() = timer.userInfo;
    if (block) {
        block();
    }
}

@end
