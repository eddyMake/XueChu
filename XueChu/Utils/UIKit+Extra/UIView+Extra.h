//
//  UIView+Extra.h
//  Baihua
//
//  Created by Lin on 15/12/1.
//  Copyright © 2015年 KuGou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extra)

/**
 *  添加毛玻璃层
 *
 *  @param blurEffectStyle UIBlurEffectStyle
 *
 *  @return 毛玻璃层View
 */
- (UIVisualEffectView *)addBlurEffectWithStyle:(UIBlurEffectStyle)blurEffectStyle;

@end
