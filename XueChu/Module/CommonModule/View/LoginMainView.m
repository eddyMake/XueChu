//
//  LoginMainView.m
//  XueChu
//
//  Created by eddy on 2018/1/3.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "LoginMainView.h"

@implementation LoginMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setUpUserInterface];
    }
    return self;
}

- (void)setUpUserInterface
{
    UIImage *logoImg = [UIImage imageNamed:@"ic-characters"];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:logoImg];
    
    [self addSubview:logoView];
    
    [logoView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(120);
    }];
    
    
    UILabel *tipLb = [[UILabel alloc] init];
    [tipLb setText:@"第三方账户登录"];
    [tipLb setTextColor:[UIColor whiteColor]];
    [tipLb setFont:[UIFont systemFontOfSize:15]];
    [tipLb setTextAlignment:NSTextAlignmentCenter];
    
    [self addSubview:tipLb];
    
    [tipLb makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.weChatLoginBtn.top).offset(-20);
    }];
    
    UIView *leftLine = [self lineView];
    [leftLine makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tipLb);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(tipLb.left).offset(-10);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *rightLine = [self lineView];
    [rightLine makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tipLb);
        make.left.equalTo(tipLb.right).offset(10);
        make.right.equalTo(self).offset(-20);
        make.height.equalTo(leftLine);
    }];
    
    [self.loginBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tipLb.top).offset(-25);
        make.left.equalTo(self).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    [self.registerBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tipLb.top).offset(-25);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(40);
        make.left.equalTo(self.loginBtn.right).offset(20);
        make.width.equalTo(self.loginBtn);
    }];
}

- (UIView *)lineView
{
    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:line];
    
    return line;
}

- (UIButton *)loginBtn
{
    if (_loginBtn == nil)
    {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_loginBtn.layer setCornerRadius:20];
        [_loginBtn.layer setMasksToBounds:YES];
        
        [self addSubview:_loginBtn];
    }
    
    return _loginBtn;
}

- (UIButton *)registerBtn
{
    if (_registerBtn == nil)
    {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setBackgroundColor:[UIColor colorWithHex:0xf4a929]];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_registerBtn.layer setCornerRadius:20];
        [_registerBtn.layer setMasksToBounds:YES];
        
        [self addSubview:_registerBtn];
    }
    
    return _registerBtn;
}

- (UIButton *)weChatLoginBtn
{
    if (_weChatLoginBtn == nil)
    {
        _weChatLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weChatLoginBtn setImage:[UIImage imageNamed:@"ic_WeChat"] forState:UIControlStateNormal];
        [_weChatLoginBtn setTitle:@" 微信登录" forState:UIControlStateNormal];
        [_weChatLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_weChatLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        [self addSubview:_weChatLoginBtn];
        
        [_weChatLoginBtn makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-25);
            make.left.equalTo(self).offset(XSScreenScaleX(40));
        }];
    }
    
    return _weChatLoginBtn;
}

- (UIButton *)qqLoginBtn
{
    if (_qqLoginBtn == nil)
    {
        _qqLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqLoginBtn setImage:[UIImage imageNamed:@"ic_qq"] forState:UIControlStateNormal];
        [_qqLoginBtn setTitle:@" QQ登录" forState:UIControlStateNormal];
        [_qqLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_qqLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        [self addSubview:_qqLoginBtn];
        
        [_qqLoginBtn makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.weChatLoginBtn);
            make.centerX.equalTo(self);
        }];
    }
    
    return _qqLoginBtn;
}

- (UIButton *)sinaLoginBtn
{
    if (_sinaLoginBtn == nil)
    {
        _sinaLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sinaLoginBtn setImage:[UIImage imageNamed:@"ic_micro"] forState:UIControlStateNormal];
        [_sinaLoginBtn setTitle:@" 微博登录" forState:UIControlStateNormal];
        [_sinaLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sinaLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        [self addSubview:_sinaLoginBtn];
        
        [_sinaLoginBtn makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.weChatLoginBtn);
            make.right.equalTo(self).offset(-XSScreenScaleX(40));
        }];
    }
    
    return _sinaLoginBtn;
}

@end
