//
//  NSString+Extra.h
//  BaihuaAuthor
//
//  Created by Lin on 15/11/3.
//  Copyright © 2015年 KuGou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Extra)

- (NSNumber *)numberValue;

- (NSDate *)dateValue;

- (NSDate *)dateValueWithFormatString:(NSString *)formatString;

- (NSDictionary *)jsonValue;

- (NSString *)md5_32BitValue;

- (CGSize)sizeWithTextSize:(CGSize)textRangeSize font:(UIFont *)font;


//时间格式----  年月日
- (NSString *)toYearMonthDayFormateWithDateString;

//时间轴－》年月日
- (NSString *)getYearMonthDayFormaterWithTimeString;


@end
