//
//  LoginMainController.m
//  XueChu
//
//  Created by eddy on 2018/1/3.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "LoginMainController.h"
#import "LoginMainView.h"

@interface LoginMainController ()

@property (nonatomic, strong) LoginMainView *mainview;

@end

@implementation LoginMainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"登录"];
    [self setNavTitleColor:[UIColor colorWithHex:0x333333]];
    [self showCustomNavigationLeftButtonWithTitle:@"取消" image:nil hightlightImage:nil];
    
    [self setUpUserInterface];
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
    [self.mainview accountTf];
    [self.mainview.forgetPasBtn addTarget:self action:@selector(forgetPasBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainview.loginBtn addTarget:self action:@selector(forgetPasBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainview.weChatLoginBtn addTarget:self action:@selector(weChatLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainview.qqLoginBtn addTarget:self action:@selector(qqLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainview.sinaLoginBtn addTarget:self action:@selector(sinaLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - ********** 事件

- (void)onNavigationLeftButtonClicked:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)forgetPasBtn:(UIButton *)sender
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
