//
//  RegisterMainController.m
//  XueChu
//
//  Created by eddy on 2018/1/3.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "RegisterMainController.h"
#import "RegisterMainView.h"

#import "SelectBirthdayController.h"

@interface RegisterMainController ()

@property (nonatomic, strong) RegisterMainView *mainview;

@end

@implementation RegisterMainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"注册"];
    [self showCustomNavigationBackButton];
    [self setNavTitleColor:[UIColor colorWithHex:0x333333]];
    
    [self setUpUserInterface];
}

#pragma mark - ********** UI

- (UIView *)customMainContentView
{
    if (_mainview == nil)
    {
        _mainview = [[RegisterMainView alloc] initWithFrame:self.mainContentViewFrame];
    }
    
    return _mainview;
}

- (void)setUpUserInterface
{
    [self.mainview accountTf];
    [self.mainview passwordTf];
    [self.mainview codeTf];
    [self.mainview.capchaBtn addTarget:self action:@selector(capchaBtn:) forControlEvents:UIControlEventTouchUpInside];

    [self.mainview.registerBtn addTarget:self action:@selector(registerBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainview.agreeBtn addTarget:self action:@selector(agreeBtn:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - ********** 事件

- (void)capchaBtn:(id)sender
{
    
}

- (void)registerBtn:(id)sender
{
    SelectBirthdayController *ctl = [[SelectBirthdayController alloc] init];
    
    [self presentViewController:ctl animated:YES completion:nil];
}

- (void)agreeBtn:(UIButton *)sender
{

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
