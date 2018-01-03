//
//  NSDate+Extra.h
//  BaihuaAuthor
//
//  Created by Lin on 15/11/3.
//  Copyright © 2015年 KuGou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extra)

+ (instancetype)nowDate;

+ (instancetype)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

// 判断传入时间对比此刻是否超过24小时
- (BOOL)isGreaterThan24Hours;

// 一天前的时间(24小时前)
- (instancetype)dayBeforeDate;

// 根据指定时间的字符串格式和时间 格式例如yyyy-MM-dd HH:mm:ss:SSS
- (NSString *)stringValueWithFormatString:(NSString *)formatString;

// 返回和当前时间的相差，返回刚刚，分钟前，小时前，昨天，yyyy年MM月dd日的日期
- (NSString *)stringValueFromNow;

// 返回和当前时间的相差（IM聊天使用），返回时分，昨天时分，月日时分，yyyy年MM月dd日 HH:mm的日期
- (NSString *)chatStringValue;

// 返回和当前时间的相差（IM会话列表使用），返回时分，昨天时分，月日时分，yyyy年MM月dd日的日期
- (NSString *)conversationStringValue;

@end
