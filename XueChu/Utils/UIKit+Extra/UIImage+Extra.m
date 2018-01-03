//
//  UIImage+Extra.m
//  BaihuaAuthor
//
//  Created by Lin on 15/11/3.
//  Copyright © 2015年 KuGou. All rights reserved.
//

#import "UIImage+Extra.h"

@implementation UIImage (Extra)

/*
 iPhone4/4s:[UIImage imageNamed:@"LaunchImage-700"];
 
 iPhone5/5s/5c： [UIImage imageNamed:@"LaunchImage-700-568h"];
 
 iPhone6： [UIImage imageNamed:@"LaunchImage-800-667h"];
 */

+ (instancetype)imageWithAutoMatchCurrentDeviceExtName:(NSString *)aExtension
{
    NSString *extName = @"png";
    if ([aExtension length] > 0)
    {
        extName = aExtension;
    }
    
    NSString *imgName = nil;
    if (isScreen3_5Inch)
    {
        imgName = @"LaunchImage-700";
    }
    else if (isScreen4Inch)
    {
        imgName = @"LaunchImage-700-568h";
    }
    else if (isScreen4_7Inch)
    {
        imgName = @"LaunchImage-800-667h";
    }
    else if (isScreen5_5Inch)
    {
        imgName = @"LaunchImage-800-Portrait-736h";
    }

    UIImage *image = [UIImage imageNamed:imgName];
    
    return image;
}

//根据当前的设备返回对应尺寸的图片
//name图片名称
//extName图片的扩展名
//图片命名必须遵守：
//iphone4--Name@2x.png
//iphone5--Name-568h@2x.png
//iphone6--Name-667h@2x.png
//iphone6Puls--Name-736h@3x.png
+ (instancetype)imageWithAutoMatchCurrentDevice:(NSString *)aName extName:(NSString *)aExtension
{
    NSString *extName = @"png";
    if ([aExtension length] > 0)
    {
        extName = aExtension;
    }
    
    NSString *imgName = aName;
    
    if (isScreen3_5Inch)
    {
        imgName = [NSString stringWithFormat:@"%@",aName];
    }
    else if (isScreen4Inch)
    {
        imgName = [NSString stringWithFormat:@"%@-568h",aName];
    }
    else if (isScreen4_7Inch)
    {
        imgName = [NSString stringWithFormat:@"%@-667h",aName];
    }
    else if (isScreen5_5Inch)
    {
        imgName = [NSString stringWithFormat:@"%@-736h",aName];
    }
    
    imgName = [NSString stringWithFormat:@"%@.%@",imgName,extName];
    UIImage *image = [UIImage imageNamed:imgName];
    
    return image;
}

+ (instancetype)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (instancetype)fixOrientation
{
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (instancetype)viewSnapshot:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    // 获取图像
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
