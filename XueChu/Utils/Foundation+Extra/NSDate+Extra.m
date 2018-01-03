//
//  NSDate+Extra.m
//  BaihuaAuthor
//
//  Created by Lin on 15/11/3.
//  Copyright © 2015年 KuGou. All rights reserved.
//

#import "NSDate+Extra.h"



@implementation NSDate (Extra)

+ (instancetype)nowDate
{
    NSDate *date = [NSDate date];
    
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    
    date = [date dateByAddingTimeInterval:interval];
    
    return date;
}

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond
{
    NSDate *date = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if(timeIntervalInMilliSecond > 140000000000)
    {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    
    date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return date;
}

// 判断传入时间对比此刻是否超过24小时
- (BOOL)isGreaterThan24Hours
{
    NSDate *dayBeforeNowDate = [[NSDate nowDate] dayBeforeDate];
    
    BOOL isGreaterThan24Hours = [dayBeforeNowDate compare:self] == NSOrderedDescending;
    
    return isGreaterThan24Hours;
}

// 一天前的时间(24小时前)
- (NSDate *)dayBeforeDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = nil;
    
    components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                             fromDate:self];
    
    NSDateComponents *dayBeforeComponents = [NSDateComponents new];
    
    [dayBeforeComponents setYear:0];
    [dayBeforeComponents setMonth:0];
    [dayBeforeComponents setDay:-1];
    
    NSDate *dayBeforeDate = [calendar dateByAddingComponents:dayBeforeComponents toDate:self options:0];
    
    return dayBeforeDate;
}

//根据指定时间的字符串格式和时间 格式例如yyyy-MM-dd HH:mm:ss:SSS
- (NSString *)stringValueWithFormatString:(NSString *)formatString
{
    NSDateFormatter *dateToStringFormatter = [NSDateFormatter new];
    
    [dateToStringFormatter setDateFormat:formatString];
    
    NSString *strDate = [dateToStringFormatter stringFromDate:self];
    
    return strDate;
}

// 返回和当前时间的相差，返回刚刚，分钟前，小时前，昨天，yyyy-MM-dd的日期
- (NSString *)stringValueFromNow
{
    NSInteger sec = 1;
    NSInteger minute = sec * 60;
    NSInteger hour = minute * 60;
    NSInteger day = hour * 24;
    
    // hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    NSDate *nowDate = [NSDate nowDate];
    
    NSTimeInterval timeDiff = [nowDate timeIntervalSinceDate:self];
    
    NSString *dateStr = nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY";
    
    NSString *beforeDateStr = [dateFormatter stringFromDate:self];
    NSString *nowDateStr = [dateFormatter stringFromDate:nowDate];
    
    if ([beforeDateStr isEqualToString:nowDateStr])
    {
        /// 同年
        if (timeDiff <= minute)
        {
            dateStr = @"刚刚";
        }
        else if (timeDiff < hour)
        {
            dateStr = [NSString stringWithFormat:@"%d分钟前", (int)(timeDiff / minute)];
        }
        else if (timeDiff <= day)
        {
            [dateFormatter setDateFormat:@"YYYYMMdd"];
            beforeDateStr = [dateFormatter stringFromDate:self];
            nowDateStr = [dateFormatter stringFromDate:nowDate];
            
            // 两天内
            if ([beforeDateStr isEqualToString:nowDateStr])
            {
                //// 在同一天
                dateStr = [NSString stringWithFormat:@"%d小时前", (int)(timeDiff / hour)];
            }
            else
            {
                ////  昨天
                dateStr = @"昨天";
            }
        }
        else
        {
            dateStr = [self stringValueWithFormatString:@"MM月dd日"];
        }
    }
    else
    {
        dateStr = [self stringValueWithFormatString:@"yyyy年MM月dd日"];
    }
    
#warning 此处需要加入12小时制处理
    if (hasAMPM)
    {
        
    }
    else
    {
        
    }
    
    return dateStr;
}

//返回和当前时间的相差（主IM用），返回时分，昨天时分，月日时分，yy-MM-dd HH:mm的日期
- (NSString *)chatStringValue
{
    NSInteger sec = 1;
    NSInteger minute = sec * 60;
    NSInteger hour = minute * 60;
    NSInteger day = hour * 24;
    
    // hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    NSDate *nowDate = [NSDate nowDate];
    
    NSTimeInterval timeDiff = [nowDate timeIntervalSinceDate:self];
    
    NSString *dateStr = nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY"];
    NSString *beforeDateStr = [dateFormatter stringFromDate:self];
    NSString *nowDateStr = [dateFormatter stringFromDate:nowDate];
    
    if ([beforeDateStr isEqualToString:nowDateStr])
    {
        // 同年
        if (timeDiff <= day)
        {
            [dateFormatter setDateFormat:@"YYYYMMdd"];
            beforeDateStr = [dateFormatter stringFromDate:self];
            nowDateStr = [dateFormatter stringFromDate:nowDate];
            
            // 两天内
            if ([beforeDateStr isEqualToString:nowDateStr])
            {
                // 在同一天
                dateStr = [self stringValueWithFormatString:@"HH:mm"];
            }
            else
            {
                //  昨天
                dateStr = [self stringValueWithFormatString:@"昨天 HH:mm"];
            }
        }
        else
        {
            dateStr = [self stringValueWithFormatString:@"M月d日 HH:mm"];
        }
    }
    else
    {
        dateStr = [self stringValueWithFormatString:@"yy-MM-dd HH:mm"];
    }
    
#warning 此处需要加入12小时制处理
    if (hasAMPM)
    {
        
    }
    else
    {
        
    }
    
    return dateStr;
}

// 返回和当前时间的相差（IM会话列表使用），返回时分，昨天时分，月日时分，yyyy年MM月dd日 HH:mm的日期
- (NSString *)conversationStringValue
{
    NSInteger sec = 1;
    NSInteger minute = sec * 60;
    NSInteger hour = minute * 60;
    NSInteger day = hour * 24;
    
    // hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    NSDate *nowDate = [NSDate nowDate];
    
    NSTimeInterval timeDiff = [nowDate timeIntervalSinceDate:self];
    
    NSString *dateStr = nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY"];
    NSString *beforeDateStr = [dateFormatter stringFromDate:self];
    NSString *nowDateStr = [dateFormatter stringFromDate:nowDate];
    
    if ([beforeDateStr isEqualToString:nowDateStr])
    {
        /// 同年
        if (timeDiff <= day)
        {
            [dateFormatter setDateFormat:@"YYYYMMdd"];
            beforeDateStr = [dateFormatter stringFromDate:self];
            nowDateStr = [dateFormatter stringFromDate:nowDate];
            
            // 两天内
            if ([beforeDateStr isEqualToString:nowDateStr])
            {
                // 在同一天
                dateStr = [self stringValueWithFormatString:@"HH:mm"];
            }
            else
            {
                //  昨天
                dateStr = [self stringValueWithFormatString:@"昨天 HH:mm"];
            }
        }
        else
        {
            dateStr = [self stringValueWithFormatString:@"MM月dd日"];
        }
    }
    else
    {
        dateStr = [self stringValueWithFormatString:@"yyyy年MM月dd日"];
    }
    
#warning 此处需要加入12小时制处理
    if (hasAMPM)
    {
        
    }
    else
    {
        
    }
    
    return dateStr;
}

@end
