//
//  LoginMainController.m
//  XueChu
//
//  Created by eddy on 2018/1/3.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "LoginMainController.h"

@interface LoginMainController ()

@end

@implementation LoginMainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"登录"];
    [self setNavTitleColor:[UIColor colorWithHex:0x333333]];
    [self showCustomNavigationLeftButtonWithTitle:@"取消" image:nil hightlightImage:nil];
}

#pragma mark - ********** 事件

- (void)onNavigationLeftButtonClicked:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
