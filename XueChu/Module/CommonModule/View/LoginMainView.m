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
        [self setBackgroundColor:[UIColor redColor]];
        
        [self setUpUserInterface];
    }
    return self;
}

- (void)setUpUserInterface
{
    [self addBottomLineWithTextField:self.accountTf];
    [self addBottomLineWithTextField:self.passwordTf];
    
    NSString *tip = @"登录即同意《用户服务协议》";
    UILabel *agreeLb = [[UILabel alloc] init];
    [agreeLb setTextColor:[UIColor fontDarkBlackColor]];
    [agreeLb setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:agreeLb];
    [agreeLb makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.agreeBtn);
        make.left.equalTo(self.agreeBtn.right).offset(6);
    }];
    
    NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:tip];
    [atts addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(5, 8)];
    [agreeLb setAttributedText:atts];
    
    UILabel *tipLb = [[UILabel alloc] init];
    [tipLb setText:@"第三方账户登录"];
    [tipLb setTextColor:[UIColor fontDarkBlackColor]];
    [tipLb setFont:[UIFont systemFontOfSize:15]];
    [tipLb setTextAlignment:NSTextAlignmentCenter];
    
    [self addSubview:tipLb];
    
    [tipLb makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.weChatLoginBtn.top).offset(-25);
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
}

- (UIView *)lineView
{
    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:[UIColor lineColor]];
    
    [self addSubview:line];
    
    return line;
}

- (UITextField *)accountTf
{
    if (_accountTf == nil)
    {
        _accountTf = [[UITextField alloc] init];
        [_accountTf setFont:[UIFont systemFontOfSize:15]];
        [_accountTf setLeftViewMode:UITextFieldViewModeAlways];
        [_accountTf setLeftView:[self textFieldLeftViewWithTitle:@"账号"]];
        [_accountTf setPlaceholder:@"请输入手机号"];
        
        [self addSubview:_accountTf];
        
        [_accountTf makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(32);
            make.right.equalTo(self).offset(-15);
            make.height.mas_equalTo(40);
        }];
    }
    
    return _accountTf;
}

- (UITextField *)passwordTf
{
    if (_passwordTf == nil)
    {
        _passwordTf = [[UITextField alloc] init];
        [_passwordTf setFont:[UIFont systemFontOfSize:15]];
        [_passwordTf setLeftViewMode:UITextFieldViewModeAlways];
        [_passwordTf setLeftView:[self textFieldLeftViewWithTitle:@"密码"]];
        [_passwordTf setPlaceholder:@"请输入密码"];
        
        [self addSubview:_passwordTf];
        
        [_passwordTf makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.accountTf.bottom).offset(22);
            make.height.left.right.equalTo(self.accountTf);
        }];
    }
    
    return _passwordTf;
}

- (UILabel *)textFieldLeftViewWithTitle:(NSString *)title
{
    UILabel *leftView = [[UILabel alloc] init];
    [leftView setFrame:CGRectMake(0, 0, 45, 40)];
    [leftView setTextColor:[UIColor fontBlackColor]];
    [leftView setFont:[UIFont systemFontOfSize:15]];
    [leftView setText:title];
    
    return leftView;
}

- (void)addBottomLineWithTextField:(UITextField *)textField
{
    UILabel *line = [[UILabel alloc] init];
    [line setBackgroundColor:[UIColor lineColor]];
    
    [self addSubview:line];
    
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(textField);
        make.height.equalTo(@0.5);
    }];
}

- (UIButton *)forgetPasBtn
{
    if (_forgetPasBtn == nil)
    {
        _forgetPasBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPasBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forgetPasBtn setTitleColor:[UIColor fontDarkBlackColor] forState:UIControlStateNormal];
        [_forgetPasBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        
        [self addSubview:_forgetPasBtn];
        
        [_forgetPasBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.passwordTf.bottom).offset(11);
            make.right.equalTo(self.passwordTf);
        }];
    }
    
    return _forgetPasBtn;
}

- (UIButton *)loginBtn
{
    if (_loginBtn == nil)
    {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setBackgroundColor:[UIColor normalButtonColor]];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_loginBtn.layer setCornerRadius:5];
        [_loginBtn.layer setMasksToBounds:YES];
        
        [self addSubview:_loginBtn];
        
        [_loginBtn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.height.mas_equalTo(44);
            make.top.equalTo(self.forgetPasBtn.bottom).offset(40);
        }];
    }
    
    return _loginBtn;
}

- (UIButton *)agreeBtn
{
    if (_agreeBtn == nil)
    {
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreeBtn setSelected:YES];
        [_agreeBtn setUserInteractionEnabled:NO];
        [_agreeBtn setImage:[UIImage imageNamed:@"ic_choice"] forState:UIControlStateNormal];
        [_agreeBtn setImage:[UIImage imageNamed:@"ic_choice"] forState:UIControlStateSelected];

        [self addSubview:_agreeBtn];
        
        [_agreeBtn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.loginBtn);
            make.top.equalTo(self.loginBtn.bottom).offset(10);
        }];
    }
    
    return _agreeBtn;
}

- (UIButton *)weChatLoginBtn
{
    if (_weChatLoginBtn == nil)
    {
        _weChatLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weChatLoginBtn setImage:[UIImage imageNamed:@"ic_WeChat_v"] forState:UIControlStateNormal];
        [_weChatLoginBtn setTitle:@"微信登录" forState:UIControlStateNormal];
        [_weChatLoginBtn setTitleColor:[UIColor fontDarkBlackColor] forState:UIControlStateNormal];
        [_weChatLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];

        [self addSubview:_weChatLoginBtn];
        
        [_weChatLoginBtn makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-25);
            make.left.equalTo(self).offset(XSScreenScaleX(40));
        }];
        
        [_weChatLoginBtn layoutIfNeeded];
        [_weChatLoginBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:10];
    }
    
    return _weChatLoginBtn;
}

- (UIButton *)qqLoginBtn
{
    if (_qqLoginBtn == nil)
    {
        _qqLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqLoginBtn setImage:[UIImage imageNamed:@"ic_qq-v"] forState:UIControlStateNormal];
        [_qqLoginBtn setTitle:@"QQ登录" forState:UIControlStateNormal];
        [_qqLoginBtn setTitleColor:[UIColor fontDarkBlackColor] forState:UIControlStateNormal];
        [_qqLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];

        [self addSubview:_qqLoginBtn];
        
        [_qqLoginBtn makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.weChatLoginBtn);
            make.centerX.equalTo(self);
        }];
        
        [_qqLoginBtn layoutIfNeeded];
        [_qqLoginBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:10];
    }
    
    return _qqLoginBtn;
}

- (UIButton *)sinaLoginBtn
{
    if (_sinaLoginBtn == nil)
    {
        _sinaLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sinaLoginBtn setImage:[UIImage imageNamed:@"ic_micro_v"] forState:UIControlStateNormal];
        [_sinaLoginBtn setTitle:@"微博登录" forState:UIControlStateNormal];
        [_sinaLoginBtn setTitleColor:[UIColor fontDarkBlackColor] forState:UIControlStateNormal];
        [_sinaLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        [self addSubview:_sinaLoginBtn];
        
        [_sinaLoginBtn makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.weChatLoginBtn);
            make.right.equalTo(self).offset(-XSScreenScaleX(40));
        }];
        
        [_sinaLoginBtn layoutIfNeeded];
        [_sinaLoginBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:10];
    }
    
    return _sinaLoginBtn;
}

@end
