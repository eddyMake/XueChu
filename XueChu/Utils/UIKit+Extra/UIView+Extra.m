//
//  UIView+Extra.m
//  Baihua
//
//  Created by Lin on 15/12/1.
//  Copyright © 2015年 KuGou. All rights reserved.
//

#import "UIView+Extra.h"

static NSInteger const kBlurEffectViewTag = 8109;

@implementation UIView (Extra)

- (UIVisualEffectView *)addBlurEffectWithStyle:(UIBlurEffectStyle)blurEffectStyle
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
    {
        return nil;
    }
    
    if (self.backgroundColor != nil)
    {
        self.backgroundColor = nil;
    }
    
    if (CGRectEqualToRect(self.frame, CGRectZero))
    {
        [self layoutIfNeeded];
    }
    
    UIVisualEffectView *blurEffectView = [self viewWithTag:kBlurEffectViewTag];
    
    if (blurEffectView == nil)
    {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:blurEffectStyle];
        
        blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.tag = kBlurEffectViewTag;
        blurEffectView.frame = self.bounds;
        
        [self addSubview:blurEffectView];
    }
    
    return blurEffectView;
}

@end
