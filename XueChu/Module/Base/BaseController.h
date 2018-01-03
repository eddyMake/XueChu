//
//  BaseController.h
//  XueChu
//
//  Created by eddy on 2018/1/2.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseController : UIViewController

/**
 *  根据各适配方法得到的 mainContentView 的 frame
 */
@property (nonatomic, assign) CGRect mainContentViewFrame;

/**
 *  布局最底层 View，所有布局都必须在此 View 上进行
 */
@property (nonatomic, strong) UIView *mainContentView;


/**
 *  是否显示导航栏，默认YES显示导航栏，如果不显示导航栏，则在子类中重写
 *
 *  @return YES显示，NO不显示
 */
- (BOOL)isShowNavigationBar;

/**
 *  是否延伸至底部标签菜单栏底部（屏幕最底），默认YES延伸，如果延伸底部标签菜单栏，则在子类中重写
 *
 *  @return YES延伸，NO不延伸
 */
- (BOOL)isExtendedBottomTabBar;

/**
 *  导航栏的高度，默认值44，如果高度不等于44，则在子类中重写
 *
 *  @return 导航栏的高度
 */
- (CGFloat)heightOfNavigationBar;

/**
 *  底部标签菜单栏的高度，默认值50，如果高度不等于50，则在子类中重写
 *
 *  @return 底部标签菜单栏TabBar的高度
 */
- (CGFloat)heightOfBottomTabBar;

/**
 *  返回当前设备的视图背景图，默认为空，如果有背景图，则在子类中重写
 *
 *  @return 当前设备的视图背景图
 */
- (UIImage *)customBackgroundImage;

/**
 *  定制 mainContentView，如果需要定制，则在子类中重写，（强烈建议在此方法中布局）请配合mainContentViewFrame使用
 *
 *  @return mainContentView，默认返回 nil，即不定制
 */
- (UIView *)customMainContentView;


- (void)setUpUserInterface;
/**
 *  导航栏左侧显示返回按钮
 */
- (void)showCustomNavigationBackButton;

/**
 *  导航栏左侧显示关闭按钮
 */
- (void)showCustomNavigationCloseButton;

// 显示导航栏左侧的按钮
- (void)showCustomNavigationLeftButtonWithTitle:(NSString *)aTitle
                                          image:(UIImage *)aImage
                                hightlightImage:(UIImage *)hImage;

// 显示导航栏右边的按钮
- (void)showCustomNavigationRightButtonWithTitle:(NSString *)aTitle
                                           image:(UIImage *)aImage
                                 hightlightImage:(UIImage *)hImage;

// 导航栏左边按钮事件
- (void)onNavigationLeftButtonClicked:(id)sender;

// 导航栏右边按钮事件
- (void)onNavigationRightButtonClicked:(id)sender;


- (void)showCustomNavigationTwoRightButtonWithFirstTitle:(NSString *)firstTitle
                                              firstImage:(UIImage *)firstImage
                                    firstHightlightImage:(UIImage *)firstHightlightImage
                                             firstAction:(SEL)firstAction
                                             secondTitle:(NSString *)secondTitle
                                             secondImage:(UIImage *)secondImage
                                   secondHightlightImage:(UIImage *)secondHightlightImage
                                            secondAction:(SEL)secondAction;

- (void)showCustomNavigationTwoLeftButtonWithFirstTitle:(NSString *)firstTitle
                                             firstImage:(UIImage *)firstImage
                                   firstHightlightImage:(UIImage *)firstHightlightImage
                                            firstAction:(SEL)firstAction
                                            secondTitle:(NSString *)secondTitle
                                            secondImage:(UIImage *)secondImage
                                  secondHightlightImage:(UIImage *)secondHightlightImage
                                           secondAction:(SEL)secondAction;

@end
