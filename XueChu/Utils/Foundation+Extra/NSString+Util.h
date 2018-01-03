//
//  NSString+Util.h
//  Baihua
//
//  Created by eddy_Mac on 15/7/31.
//  Copyright (c) 2015年 KuGou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)

#pragma mark - ------验证---------
//手机号码验证
- (BOOL)validateMobile;
//密码
- (BOOL)validatePassword;
//昵称
- (BOOL)validateNickname;

@end
