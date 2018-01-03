//
//  CustomTaBarController.m
//  XueChu
//
//  Created by eddy on 2018/1/3.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "CustomTaBarController.h"
#import "BaseNavigationController.h"
#import "CookBookController.h"
#import "CategoryController.h"
#import "FindController.h"
#import "MineController.h"

#import "RDVTabBarItem.h"

@interface CustomTaBarController ()

@end

@implementation CustomTaBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpChildController];
}

- (void)setUpChildController
{
    CookBookController *firstViewController = [[CookBookController alloc] init];
    UIViewController *firstNavigationController = [[BaseNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    CategoryController *secondViewController = [[CategoryController alloc] init];
    UIViewController *secondNavigationController = [[BaseNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    FindController *thirdViewController = [[FindController alloc] init];
    UIViewController *thirdNavigationController = [[BaseNavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    MineController *fourthViewController = [[MineController alloc] init];
    UIViewController *fourthNavigationController = [[BaseNavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    
    [self setViewControllers:@[
                               firstNavigationController,
                               secondNavigationController,
                               thirdNavigationController,
                               fourthNavigationController,
                               ]];
    
    //tabBar
    [[self tabBar] setHeight:50];
    [self tabBar].backgroundView .backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    lineView.backgroundColor =  [UIColor grayColor];
    [[self tabBar].backgroundView addSubview:lineView];
    
    
    //tabBarItem
    NSArray *tabBarItemNormalImages = @[@"ic_home", @"ic_activity", @"ic_find", @"ic_mine"];
    NSArray *tabBarItemSelectedImages = @[@"ic_home_v", @"ic_activity_v", @"ic_find_v", @"ic_mine_v"];
    NSArray *tabBarItemTitles = @[@"食谱",@"分类",@"发现",@"我的"];
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[self tabBar] items])
    {
        UIImage *selectedimage = [UIImage imageNamed:tabBarItemSelectedImages[index]];
        UIImage *unselectedimage = [UIImage imageNamed:tabBarItemNormalImages[index]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        item.title = tabBarItemTitles[index];
        
        item.unselectedTitleAttributes = @{
                                           NSFontAttributeName : [UIFont systemFontOfSize:10],
                                           NSForegroundColorAttributeName : [UIColor grayColor]
                                           };
        item.selectedTitleAttributes = @{
                                         NSFontAttributeName : [UIFont systemFontOfSize:10],
                                         NSForegroundColorAttributeName : [UIColor redColor]
                                         };
        item.titlePositionAdjustment = UIOffsetMake(0,3);
        item.imagePositionAdjustment = UIOffsetMake(0,-2);
        index++;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
