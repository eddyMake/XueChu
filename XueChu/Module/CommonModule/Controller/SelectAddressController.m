//
//  SelectAddressController.m
//  XueChu
//
//  Created by eddy on 2018/1/4.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "SelectAddressController.h"

@interface SelectAddressController ()

@end

@implementation SelectAddressController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpUserInterface];
}

#pragma mark - ******** UI

- (void)setUpUserInterface
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(44, 44));
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
    }];
    
    
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:25]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor fontBlackColor]];
    [label setText:@"你所在的城市?"];
    [self.view addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(XSScreenScaleY(90));
    }];
    
    
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_location"]];
    [self.view addSubview:imageview];
    [imageview makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(label.bottom).offset(XSScreenScaleY(60));
    }];
    
    UIButton *addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addressBtn setTitleColor:[UIColor fontBlackColor] forState:UIControlStateNormal];
    [addressBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [addressBtn setTitle:@"广州市，番禺区" forState:UIControlStateNormal];
    [addressBtn setBackgroundColor:[UIColor mainColor]];
    [addressBtn.layer setCornerRadius:21];
    [addressBtn.layer setMasksToBounds:YES];
    [addressBtn addTarget:self action:@selector(addressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addressBtn];
    [addressBtn sizeToFit];
    [addressBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(addressBtn.category_width + 30, addressBtn.category_height + 15));
        make.top.equalTo(imageview.bottom).offset(15);
    }];
    
    UIButton * startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [startBtn setTitle:@"开启体验" forState:UIControlStateNormal];
    [startBtn setBackgroundColor:[UIColor normalButtonColor]];
    [startBtn.layer setCornerRadius:21];
    [startBtn.layer setMasksToBounds:YES];
    [startBtn addTarget:self action:@selector(startBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    [startBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(203, 42));
        make.bottom.equalTo(self.view).offset(-XSScreenScaleY(80));
    }];
}

#pragma mark - ********* 事件

- (void)backBtn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)startBtn:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SERVER_RESPONSE_UI object:nil];
}

- (void)addressBtn:(UIButton *)sender
{
    
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
