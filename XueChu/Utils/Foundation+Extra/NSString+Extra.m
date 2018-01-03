//
//  NSString+Extra.m
//  BaihuaAuthor
//
//  Created by Lin on 15/11/3.
//  Copyright © 2015年 KuGou. All rights reserved.
//

#import "NSString+Extra.h"
#import <CommonCrypto/CommonDigest.h>


static NSString * const kTimeFormatStringSec = @"yyyy-MM-dd HH:mm:ss";
static NSString * const kTimeFormatStringDay = @"yyyy/MM/dd";
static NSString * const kTimeFormatStringMonth = @"yyyy-MM";


@implementation NSString (Extra)

- (NSNumber *)numberValue
{
    return [NSNumber numberWithInteger:[self integerValue]];
}

- (NSDate *)dateValue
{
    return [self dateValueWithFormatString:kTimeFormatStringSec];
}

- (NSDate *)dateValueWithFormatString:(NSString *)formatString;
{
    NSDateFormatter *stringToDateFormatter = [[NSDateFormatter alloc] init];
    stringToDateFormatter.dateFormat = formatString;
    
    NSDate *date = [stringToDateFormatter dateFromString:self];
    
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    
    date = [date dateByAddingTimeInterval:interval];
    
    return date;
}

- (NSDictionary *)jsonValue
{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}

- (NSString *)md5_32BitValue
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (unsigned int)self.length, digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

- (CGSize)sizeWithTextSize:(CGSize)textRangeSize font:(UIFont *)font
{
    CGSize strSize = CGSizeZero;
    
    if (self.length > 0)
    {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSDictionary *attributesDic = @{NSFontAttributeName: font,
                                        NSParagraphStyleAttributeName: paragraphStyle};
        
        CGRect textRect = [self boundingRectWithSize:textRangeSize
                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                          attributes:attributesDic
                                             context:nil];
        
        strSize = CGSizeMake(textRect.size.width, ceil(textRect.size.height));
    }
    
    return strSize;
}



//时间格式----  年月日
- (NSString *)toYearMonthDayFormateWithDateString
{
    if ([self isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    NSArray *timeArray = [self componentsSeparatedByString:@" "];
    NSMutableString *mutableStr = [NSMutableString string];
    if (timeArray.count)
    {
        if ([timeArray[0] rangeOfString:@"-"].location != NSNotFound)
        {
            NSArray *timeTwo = [(NSString *)timeArray[0] componentsSeparatedByString:@"-"];
            NSArray *two = @[@"年",@"月",@"日"];
            for (int i = 0; i < timeTwo.count; i++)
            {
                [mutableStr appendFormat:@"%@%@",timeTwo[i],two[i]];
            }
        }
        return mutableStr;
    }
    return nil;
}

- (NSString *)getYearMonthDayFormaterWithTimeString
{
    if (self.length == 0)
    {
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}



@end
