//
//  Global.h
//  XueChu
//
//  Created by eddy on 2018/1/3.
//  Copyright © 2018年 eddy. All rights reserved.
//

#ifndef Global_h
#define Global_h

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

#define kScreen3_5InchSize CGSizeMake(640, 960)
#define kScreen4InchSize   CGSizeMake(640, 1136)
#define kScreen4_7InchSize CGSizeMake(750, 1334)
#define kScreen5_5InchSize CGSizeMake(1242, 2208)

#define isScreen3_5Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(kScreen3_5InchSize, [[UIScreen mainScreen] currentMode].size) : NO)
#define isScreen4Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(kScreen4InchSize, [[UIScreen mainScreen] currentMode].size) : NO)
#define isScreen4_7Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(kScreen4_7InchSize, [[UIScreen mainScreen] currentMode].size) : NO)
#define isScreen5_5Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(kScreen5_5InchSize, [[UIScreen mainScreen] currentMode].size) : NO)

#define SCREEN_MAX_LENGTH MAX(kScreenWidth,kScreenHeight)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTopHeight (kStatusBarHeight + kNavBarHeight)
#define kTabBarHeight (kStatusBarHeight > 20 ? 83 : 49)

// 日志输出
#ifdef DEBUG
#   define BLTLog(fmt, ...) {NSLog((@"[Line %d] " fmt), __LINE__, ##__VA_ARGS__);}
#else
#   define BLTLog(...)
#endif

//屏幕缩放
//以iphone6为参考，如果不是iphone作为参考，则要改变值
#define XSScreenScaleX(x) x*[UIScreen mainScreen].bounds.size.width/375.0
#define XSScreenScaleY(y) y*[UIScreen mainScreen].bounds.size.height/667.0

#define strongify(...) \
rac_keywordify \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
metamacro_foreach(rac_strongify_,, __VA_ARGS__) \
_Pragma("clang diagnostic pop")

#define weakify(...) \
rac_keywordify \
metamacro_foreach_cxt(rac_weakify_,, __weak, __VA_ARGS__)

#endif /* Global_h */
