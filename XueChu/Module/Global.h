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

#endif /* Global_h */
