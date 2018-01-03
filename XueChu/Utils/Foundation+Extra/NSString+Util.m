//
//  NSString+Util.m
//  Baihua
//
//  Created by eddy_Mac on 15/7/31.
//  Copyright (c) 2015年 KuGou. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)

#pragma mark - ------验证---------
//手机号码验证
- (BOOL)validateMobile
{
    NSString *pattern = @"^1+[34578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

//密码
- (BOOL)validatePassword
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}


//昵称  只含有汉字、数字、字母、下划线
- (BOOL)validateNickname
{
    NSString *nicknameRegex = @"^[a-zA-Z0-9_\u4e00-\u9fa5]{2,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}


@end
