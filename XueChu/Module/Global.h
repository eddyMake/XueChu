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

// 日志输出
#ifdef DEBUG
#   define BLTLog(fmt, ...) {NSLog((@"[Line %d] " fmt), __LINE__, ##__VA_ARGS__);}
#else
#   define BLTLog(...)
#endif

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
