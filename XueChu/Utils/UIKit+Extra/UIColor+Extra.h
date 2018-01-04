//
//  UIColor+Extra.h
//  BaihuaAuthor
//
//  Created by Lin on 15/11/3.
//  Copyright © 2015年 KuGou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extra)

// 根据十六进制字符串生成Color
+ (instancetype)colorWithHexColorString:(NSString *)hexColorString;

// 根据十六进制字符串生成Color
+ (instancetype)colorWithHexColorString:(NSString *)hexColorString alpha:(CGFloat)alpha;

// 根据十六进制生成Color
+ (instancetype)colorWithHex:(NSInteger)hexValue;

// 根据十六进制生成Color
+ (instancetype)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;

//UI主色
+ (UIColor *)mainColor;

//统一底部大按钮颜色
+ (UIColor *)normalButtonColor;

//不可交互按钮颜色
+ (UIColor *)enableButtonColor;

//一般灰
+ (UIColor *)normalGrayColor;

//分割线描边 （较灰）
+ (UIColor *)lineColor;

//提示性矩形框描边 （小灰）
+ (UIColor *)rectangleLineColor;

//提示性矩形框背景色 (浅灰）
+ (UIColor *)rectangleBgColor;

//主要字体色 （较黑）
+ (UIColor *)fontBlackColor;

//次要字体色 （小黑）
+ (UIColor *)fontDarkBlackColor;

//提示字体色 （浅灰）
+ (UIColor *)fontLightBlackColor;

+ (UIColor *)fontGrayColor;

@end
