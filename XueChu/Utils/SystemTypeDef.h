//
//  SystemTypeDef.h
//  Baihua
//
//  Created by Lin on 12-10-31.
//  Copyright (c) 2015年 KuGou. All rights reserved.
//  项目中公共的类型定义文件
//

#ifndef Baihua_SystemTypeDef_h
#define Baihua_SystemTypeDef_h



#pragma mark - ******** 页面跳转

typedef NS_ENUM(NSUInteger, InterfaceJumpType)
{
    InterfaceJumpTypeMyComments,        // 我的评论，评论被点赞
    InterfaceJumpTypeReceivedComments,  // 收到的评论，评论被回复
    InterfaceJumpTypeArticleContent,    // 文章内容，订阅文章更新
    InterfaceJumpTypeChat,              // 聊天，IM消息
    InterfaceJumpTypeSystemMessage,     // 系统消息
    InterfaceJumpTypeAuthorDetail,      // 作者详情
};


#pragma mark - ******** 自动离线

typedef NS_ENUM(NSUInteger, AutoOfflineCacheStatus)
{
    AutoOfflineCacheStatusHaveNot,      // 没有缓存
    AutoOfflineCacheStatusDownloading,  // 下载中，瞬时状态
    AutoOfflineCacheStatusSuspend,      // 已暂停，瞬时状态
    AutoOfflineCacheStatusIncomplete,   // 不完整
    AutoOfflineCacheStatusComplete,     // 完整
};

#pragma mark - ******** 联系人

// 联系人类型
typedef NS_OPTIONS(NSInteger, ContactsType)
{
    ContactsTypeStranger        = 1 << 0,       // 陌生人
    ContactsTypeNormal          = 1 << 1,       // 邮箱联系人
};

#pragma mark - ******** 消息

typedef NS_ENUM(NSInteger, LinkType)
{
    LinkTypeNone            = 0,
    LinkTypeURL             = 1,          // 电话
    LinkTypePhoneNumber     = 2,          // 链接
    LinkTypeEmail           = 3,          // 邮箱
    LinkTypeUserHandle      = 4,          // @
    LinkTypeHashtag         = 5,          // #..#
    
    LinkTypeOther           = 31,
};


#pragma mark - ******** 支付

typedef NS_ENUM(NSUInteger, PayType)
{
    PayTypeAlipay,          // 支付宝
    PayTypeWechatPay,       // 微信
};

typedef NS_ENUM(NSInteger, PayStatus)
{
    PayStatusNotPay     = -1,         //未支付
    PayStatusPaying     = 0,          //支付中
    PayStatusPaySuccess = 1,          //支付成功
    PayStatusPayFailure = 2,          //支付失败
};

#pragma mark - ******** 我

typedef NS_ENUM(NSInteger, ModifyInfoType)
{
    ModifyUserNickName = 111, //修改昵称
    ModifyUserPhoto,          //修改头像
};

//登录类型
typedef NS_ENUM(NSInteger, LoginType)
{
    LoginTypeQQLogin          = 1,          //qq
    LoginTypeSinaLogin        = 3,          // 新浪
    LoginTypeWechatLogin      = 36,         // 微信
    
    LoginTypeOtherLogin       = 111,        //原生
};

#endif
