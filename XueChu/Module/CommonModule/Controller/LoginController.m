//
//  LoginController.m
//  XueChu
//
//  Created by eddy on 2018/1/3.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "LoginController.h"
#import "LoginMainView.h"

@interface LoginController ()

@property (nonatomic, strong) LoginMainView *mainview;

@end

@implementation LoginController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpUserInterface];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - ********** UI

- (UIView *)customMainContentView
{
    if (_mainview == nil)
    {
        _mainview = [[LoginMainView alloc] initWithFrame:self.mainContentViewFrame];
    }
    
    return _mainview;
}

- (void)setUpUserInterface
{
    [self.mainview.weChatLoginBtn addTarget:self action:@selector(weChatLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainview.qqLoginBtn addTarget:self action:@selector(qqLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainview.sinaLoginBtn addTarget:self action:@selector(sinaLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainview.loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainview.registerBtn addTarget:self action:@selector(registerBtn:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - ********** 事件

- (void)loginBtn:(UIButton *)sender
{
    
}

- (void)registerBtn:(UIButton *)sender
{
    
}

- (void)weChatLoginBtn:(UIButton *)sender
{
    
}

- (void)qqLoginBtn:(UIButton *)sender
{
    
}

- (void)sinaLoginBtn:(UIButton *)sender
{
    
}

#pragma mark - ********** 基类重写

- (UIImage *)customBackgroundImage
{
    return [UIImage imageNamed:@"login_bg"];
}

- (BOOL)isShowNavigationBar
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
