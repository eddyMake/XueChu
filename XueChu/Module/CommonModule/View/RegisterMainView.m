//
//  RegisterMainView.m
//  XueChu
//
//  Created by eddy on 2018/1/4.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "RegisterMainView.h"

@implementation RegisterMainView

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
    [self addBottomLineWithTextField:self.codeTf];

    NSString *tip = @"注册即同意《用户服务协议》";
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

- (UITextField *)accountTf
{
    if (_accountTf == nil)
    {
        _accountTf = [[UITextField alloc] init];
        [_accountTf setFont:[UIFont systemFontOfSize:15]];
        [_accountTf setLeftViewMode:UITextFieldViewModeAlways];
        [_accountTf setLeftView:[self textFieldLeftViewWithTitle:@"+86"]];
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
        [_passwordTf setPlaceholder:@"请设置密码"];
        
        [self addSubview:_passwordTf];
        
        [_passwordTf makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.accountTf.bottom).offset(22);
            make.height.left.right.equalTo(self.accountTf);
        }];
    }
    
    return _passwordTf;
}

- (UITextField *)codeTf
{
    if (_codeTf == nil)
    {
        _codeTf = [[UITextField alloc] init];
        [_codeTf setFont:[UIFont systemFontOfSize:15]];
        [_codeTf setLeftViewMode:UITextFieldViewModeAlways];
        [_codeTf setLeftView:[self textFieldLeftViewWithTitle:@"验证码"]];
        [_codeTf setPlaceholder:@"请输入验证码"];
        
        [self addSubview:_codeTf];
        
        [_codeTf makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.passwordTf.bottom).offset(22);
            make.height.left.right.equalTo(self.accountTf);
        }];
    }
    
    return _codeTf;
}

- (UILabel *)textFieldLeftViewWithTitle:(NSString *)title
{
    UILabel *leftView = [[UILabel alloc] init];
    [leftView setTextColor:[UIColor fontBlackColor]];
    [leftView setFont:[UIFont systemFontOfSize:15]];
    [leftView setText:title];
    
    if ([title rangeOfString:@"验证码"].location != NSNotFound)
    {
        [leftView setFrame:CGRectMake(0, 0, 60, 40)];
    }
    else
    {
        [leftView setFrame:CGRectMake(0, 0, 45, 40)];
    }
    
    return leftView;
}

- (UIButton *)registerBtn
{
    if (_registerBtn == nil)
    {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setBackgroundColor:[UIColor normalButtonColor]];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_registerBtn.layer setCornerRadius:5];
        [_registerBtn.layer setMasksToBounds:YES];
        
        [self addSubview:_registerBtn];
        
        [_registerBtn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.height.mas_equalTo(44);
            make.top.equalTo(self.codeTf.bottom).offset(40);
        }];
    }
    
    return _registerBtn;
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
            make.left.equalTo(self.registerBtn);
            make.top.equalTo(self.registerBtn.bottom).offset(10);
        }];
    }
    
    return _agreeBtn;
}

@end
