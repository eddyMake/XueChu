//
//  NotificationNameDefine.h
//  Baihua
//
//  Created by Lin on 12-10-31.
//  Copyright (c) 2015年 KuGou. All rights reserved.
//  项目中公共的消息通知名称定义文件
//

#ifndef Baihua_NotificationNameDefine_h
#define Baihua_NotificationNameDefine_h

#import <Foundation/Foundation.h>


#pragma mark - ******** 外链

// 点击外链分享提示，通知登录页是否弹窗
extern NSString * const OUTSIDE_CHAIN_PROMPT_UI;

#pragma mark - ******** 推送

// 消息推送处理
extern NSString * const PUSH_RESPONSE_UI;

#pragma mark - ******** 账号相关

//登陆服务器
extern NSString * const LOGIN_SERVER_RESPONSE;
extern NSString * const LOGIN_SERVER_RESPONSE_UI;

//帐号登出
extern NSString * const LOGOUT_ACCOUNT;
extern NSString * const LOGOUT_ACCOUNT_UI;

//重新登录
extern NSString * const LOGIN_AGAIN;

//自动登录失败
extern NSString * const AUTOLOGINERROR;

//关注界面跳转至引导搜索界面
extern NSString * const FOCUSVIEW_TO_GUIDEVIEW_UI;

//引导搜索界面跳转至关注界面
extern NSString * const GUIDEVIEW_TO_FOCUSVIEW_UI;

//登录界面隐藏键盘
extern NSString * const HIDEKEYBOARD_INLOGINVIEWCONTROLLER_UI;

// 账户变动
extern NSString * const ACCOUNT_CHANGED;
extern NSString * const ACCOUNT_CHANGED_UI;

//注册register
extern NSString * const REGISTER_SERVER_RESPONSE;
extern NSString * const REGISTER_SERVER_RESPONSE_UI;

extern NSString * const GETVERIFY_REGISTER_SERVER_RESPONSE;
extern NSString * const GETVERIFY_REGISTER_SERVER_RESPONSE_UI;

//忘记密码
extern NSString * const FORGETPWD_SERVER_RESPONSE;
extern NSString * const FORGETPWD_SERVER_RESPONSE_UI;

extern NSString * const GETVERIFY_FORGETPWD_SERVER_RESPONSE;
extern NSString * const GETVERIFY_FORGETPWD_SERVER_RESPONSE_UI;


#pragma mark - ******** 订阅

// 清除文章内容缓存
extern NSString * const CLEAN_ARTICLES_CONTENT_CACHE_RESPONSE_UI;

#pragma mark - ******** 关注

//当作者的文章被赞 评论时 更新作者页面的数据
extern NSString * const UPDATE_AUTHOR_ARTICLE_DATA;

// 关注列表变化
extern NSString * const FOCUSNUMBER_CHANGE;

// 添加订阅跳转
extern NSString * const ADD_SUBSCRIBE_JUMP_UI;

//未读数
extern NSString * const UNREAD_MESSAGE_COUNT;

// 添加关注
extern NSString * const SUBSCRIBE_AUTHOR_RESPONSE_UI;

// 取消关注
extern NSString * const UNSUBSCRIBE_AUTHOR_RESPONSE_UI;


#pragma mark - ******** 支付


//支付结果
extern NSString * const PAYRESULT;


//微信支付 支付宝提交并获取信息
extern NSString * const PAYCOMMIT_GET_RESULTINFO;

//支付成功之后返回群组信息
extern NSString * const PAYSUCCESS_GET_GROUPINFO;


//系统通知  收到评论角标清零
extern NSString * const PUSH_NOTICETYPE_REPLAY_COMMENT;
extern NSString * const PUSH_NOTICETYPE_SYSTEMNOTICE;

#pragma mark - ******** 消息 照片

//需要发送的相册照片数据
extern NSString * const SEND_ALBUM_PHOTO_RESPONSE_UI;

#endif
