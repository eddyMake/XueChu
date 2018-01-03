//
//  CookBookController.m
//  XueChu
//
//  Created by eddy on 2018/1/3.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "CookBookController.h"

@interface CookBookController ()

@end

@implementation CookBookController

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (BOOL)isShowNavigationBar
{
    return NO;
}

- (BOOL)isExtendedBottomTabBar
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
