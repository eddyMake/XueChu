//
//  BaseNavigationController.m
//  XueChu
//
//  Created by eddy on 2018/1/2.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor mainColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]]; //去除黑线
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    if(self.viewControllers.count > 1)
    {
        [self setHidesBottomBarWhenPushed:YES];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
