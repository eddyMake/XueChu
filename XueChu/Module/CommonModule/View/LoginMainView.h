//
//  LoginMainView.h
//  XueChu
//
//  Created by eddy on 2018/1/3.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "BaseView.h"

@interface LoginMainView : BaseView

@property (nonatomic, strong) UITextField *accountTf;
@property (nonatomic, strong) UITextField *passwordTf;

@property (nonatomic, strong) UIButton *forgetPasBtn;
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UIButton *agreeBtn;

@property (nonatomic, strong) UIButton *weChatLoginBtn;
@property (nonatomic, strong) UIButton *qqLoginBtn;
@property (nonatomic, strong) UIButton *sinaLoginBtn;

@end
