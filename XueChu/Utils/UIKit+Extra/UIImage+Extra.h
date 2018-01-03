//
//  UIImage+Extra.h
//  BaihuaAuthor
//
//  Created by Lin on 15/11/3.
//  Copyright © 2015年 KuGou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extra)

+ (instancetype)imageWithAutoMatchCurrentDeviceExtName:(NSString *)aExtension;
// 根据当前的设备返回对应尺寸的图片
// name图片名称
// extName图片的扩展名
// 图片命名必须遵守：
// iphone4--Name@2x.png
// iphone5--Name-568h@2x.png
// iphone6--Name-667h@2x.png
// iphone6Puls--Name-736h@3x.png
+ (instancetype)imageWithAutoMatchCurrentDevice:(NSString *)aName extName:(NSString *)aExtension;

+ (instancetype)imageWithColor:(UIColor *)color;

- (instancetype)fixOrientation;

+ (instancetype)viewSnapshot:(UIView *)view;

@end
