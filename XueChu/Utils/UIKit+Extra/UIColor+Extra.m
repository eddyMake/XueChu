//
//  UIColor+Extra.m
//  BaihuaAuthor
//
//  Created by Lin on 15/11/3.
//  Copyright © 2015年 KuGou. All rights reserved.
//

#import "UIColor+Extra.h"

@implementation UIColor (Extra)

// 根据十六进制字符串生成Color
+ (instancetype)colorWithHexColorString:(NSString *)hexColorString
{
    return [UIColor colorWithHexColorString:hexColorString alpha:1.0];
}

// 根据十六进制字符串生成Color
+ (instancetype)colorWithHexColorString:(NSString *)hexColorString alpha:(CGFloat)alpha
{
    unsigned int red, green, blue;
    
    NSRange range;
    
    range.length = 2;
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColorString substringWithRange:range]] scanHexInt:&red];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColorString substringWithRange:range]] scanHexInt:&green];
    
    range.location = 6;
    [[NSScanner scannerWithString:[hexColorString substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red / 255.0f)
                           green:(float)(green / 255.0f)
                            blue:(float)(blue / 255.0f)
                           alpha:alpha];
}

// 根据十六进制生成Color
+ (instancetype)colorWithHex:(NSInteger)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

// 根据十六进制生成Color
+ (instancetype)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hexValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

//UI主色
+ (UIColor *)mainColor
{
    return [UIColor colorWithHexColorString:@"0xf2db8c"];
}

//统一底部大按钮颜色
+ (UIColor *)normalButtonColor
{
    return [UIColor colorWithHexColorString:@"0xf4a929"];
}

+ (UIColor *)enableButtonColor
{
    return [UIColor colorWithHexColorString:@"0xd0d3dd"];
}

//分割线描边 （较灰）
+ (UIColor *)lineColor
{
    return [UIColor colorWithHexColorString:@"0xd9dbdb"];
}

//提示性矩形框描边 （小灰）
+ (UIColor *)rectangleLineColor
{
    return [UIColor colorWithHexColorString:@"0xcccccc"];
}

//提示性矩形框背景色 (浅灰）
+ (UIColor *)normalGrayColor
{
    return [UIColor colorWithHexColorString:@"0xf2f2f2"];
}

//提示性矩形框背景色 (浅灰）
+ (UIColor *)rectangleBgColor
{
    return [UIColor colorWithHexColorString:@"0xf5f5f5"];
}

//主要字体色 （较黑）
+ (UIColor *)fontBlackColor
{
    return [UIColor colorWithHexColorString:@"0x333333"];
}

//次要字体色 （小黑）
+ (UIColor *)fontDarkBlackColor
{
    return [UIColor colorWithHexColorString:@"0xadadad"];
}

//提示字体色 （浅灰）
+ (UIColor *)fontLightBlackColor
{
    return [UIColor colorWithHexColorString:@"0xa8a9a9"];
}

//系统灰
+ (UIColor *)fontGrayColor
{
    return  [UIColor colorWithHexColorString:@"0x333333"];
}

@end
