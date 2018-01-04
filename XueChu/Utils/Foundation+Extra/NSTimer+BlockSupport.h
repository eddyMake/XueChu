//
//  NSTimer+BlockSupport.h
//  Buy
//
//  Created by BinghongLee on 16/3/5.
//  Copyright © 2016年 KuGou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (BlockSupport)

+ (NSTimer *)bs_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)())block
                                       repeats:(BOOL)repeats;

+ (NSTimer *)bs_timerWithTimeInterval:(NSTimeInterval)interval block:(void (^)())block repeats:(BOOL)repeats;

@end
