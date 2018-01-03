//
//  BaseController.m
//  XueChu
//
//  Created by eddy on 2018/1/2.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "BaseController.h"

const CGFloat kStatusBarheight     = 20.0;
const CGFloat kNavigationBarheight = 44.0;
const CGFloat kTabBarheight        = 49.0;

@interface BaseController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UIImageView *backgroundImgView;

@end

@implementation BaseController

#pragma mark - 私有
// 初始化主内容视图位置
- (void)initMainContentViewFrame
{
    CGFloat navHeight = [self heightOfNavigationBar];
    CGFloat tabbarHeight = 0;
    
    if (self.hidesBottomBarWhenPushed == YES)
    {
        if (![self isExtendedBottomTabBar])
        {
            tabbarHeight = [self heightOfBottomTabBar];
        }
    }
    
    CGFloat stateBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    UIScreen *scr = [UIScreen mainScreen];
    CGRect rect = scr.bounds;
    
    BOOL isShowNavBar = [self isShowNavigationBar];
    if (isShowNavBar)
    {
        _mainContentViewFrame = CGRectMake(0, 0, rect.size.width, rect.size.height - (navHeight + stateBarHeight) - tabbarHeight);
    }
    else
    {
        _mainContentViewFrame = CGRectMake(0, 0, rect.size.width, rect.size.height - tabbarHeight);
    }
}

// 设置带导航栏的主视图背景图
- (void)setupMainBackgroundImgView
{
    UIImage *bgImg = [self customBackgroundImage];
    
    if (bgImg == nil)
    {
        return;
    }
    
    UIScreen *scr = [UIScreen mainScreen];
    
    CGFloat stateBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navbarHeight = [self heightOfNavigationBar];
    CGFloat bgHeight = 0;
    
    if ([self isShowNavigationBar])
    {
        bgHeight = -(stateBarHeight + navbarHeight);
    }
    
    CGRect rect = scr.bounds;
    
    [_backgroundImgView removeFromSuperview];
    _backgroundImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, bgHeight, rect.size.width, rect.size.height)];
    _backgroundImgView.userInteractionEnabled = YES;
    _backgroundImgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _backgroundImgView.image = bgImg;
    [self.view addSubview:_backgroundImgView];
    [self.view sendSubviewToBack:_backgroundImgView];
}

#pragma mark - 适配不同寸屏的代码

/**
 *  是否显示导航栏，默认 显示导航栏，如果不显示导航栏，则在子类中重写
 *
 *  @return YES显示，NO不显示
 */
- (BOOL)isShowNavigationBar
{
    return YES;
}

/**
 *  是否延伸至底部标签菜单栏底部（屏幕最底），默认YES延伸，如果延伸底部标签菜单栏，则在子类中重写
 *
 *  @return YES延伸，NO不延伸
 */
- (BOOL)isExtendedBottomTabBar
{
    return YES;
}

/**
 *  导航栏的高度，默认值44，如果高度不等于44，则在子类中重写
 *
 *  @return 导航栏的高度
 */
- (CGFloat)heightOfNavigationBar
{
    return kNavigationBarheight;
}

/**
 *  底部标签菜单栏的高度，默认值50，如果高度不等于50，则在子类中重写
 *
 *  @return 底部标签菜单栏TabBar的高度
 */
- (CGFloat)heightOfBottomTabBar
{
    return kTabBarheight;
}

/**
 *  返回当前设备的视图背景图，默认为空，如果有背景图，则在子类中重写
 *
 *  @return 当前设备的视图背景图
 */
- (UIImage *)customBackgroundImage
{
    return nil;
}

/**
 *  定制 mainContentView，如果需要定制，则在子类中重写
 *
 *  @return mainContentView，默认返回 nil
 */
- (UIView *)customMainContentView
{
    return nil;
}

- (void)setUpUserInterface
{}

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self initMainContentViewFrame];
    
    _mainContentView = [self customMainContentView];
    
    if ([self customBackgroundImage] == nil)
    {
        _mainContentView.backgroundColor = [UIColor grayColor];
    }
    
    [view addSubview:self.mainContentView];
    
    self.view = view;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 左滑返回
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        if (self.navigationController.viewControllers.firstObject != self)
        {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
    }
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 设置背景图
    [self setupMainBackgroundImgView];
    
    self.navigationItem.titleView = self.titleLabel;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willChangeStatusBarFrame:)
                                                 name:UIApplicationWillChangeStatusBarFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangeStatusBarFrame:)
                                                 name:UIApplicationDidChangeStatusBarFrameNotification
                                               object:nil];
}

- (void)willChangeStatusBarFrame:(NSNotification *)aNotification
{
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    if (statusBarHeight > 20 && [self isShowNavigationBar])
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            self.mainContentView.frame = CGRectMake(self.mainContentView.frame.origin.x,
                                                    self.mainContentView.frame.origin.y,
                                                    self.mainContentView.frame.size.width,
                                                    self.mainContentView.frame.size.height + 20 - statusBarHeight);
        }];
    }
}

- (void)didChangeStatusBarFrame:(NSNotification *)aNotification
{
    NSDictionary *userInfo = aNotification.userInfo;
    
    CGFloat statusBarHeight = [(NSValue*)userInfo[UIApplicationStatusBarFrameUserInfoKey] CGRectValue].size.height;
    
    if (statusBarHeight > 20 && [self isShowNavigationBar])
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            self.mainContentView.frame = CGRectMake(self.mainContentView.frame.origin.x,
                                                    self.mainContentView.frame.origin.y,
                                                    self.mainContentView.frame.size.width,
                                                    self.mainContentView.frame.size.height - 20 + statusBarHeight);
        }];
    }
}


- (UIView *)mainContentView
{
    if (_mainContentView == nil)
    {
        _mainContentView = [[UIView alloc] initWithFrame:_mainContentViewFrame];
        
        if ([self customBackgroundImage] == nil)
        {
            _mainContentView.backgroundColor = [UIColor grayColor];
        }
    }
    
    return _mainContentView;
}

- (void)setTitle:(NSString *)title
{
    self.navigationItem.titleView = self.titleLabel;
    
    self.titleLabel.text = title;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _titleLabel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    BLTLog(@"%@~~~~~~~~~~~~~~~~~~dealloc~~",[self class]);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        if (self.navigationController.viewControllers.firstObject != self)
        {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
        else
        {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (![[self.navigationController viewControllers] containsObject:self])
    {
        [self onNavigationLeftButtonClicked:nil];
    }
}

- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated
{
    if ([super respondsToSelector:@selector(presentModalViewController:animated:)])
    {
        [super presentModalViewController:modalViewController animated:animated];
    }
    else
    {
        [super presentViewController:modalViewController animated:animated completion:nil];
    }
}


- (void)dismissModalViewControllerAnimated:(BOOL)animated
{
    if ([super respondsToSelector:@selector(dismissModalViewControllerAnimated:)])
    {
        [super dismissModalViewControllerAnimated:animated];
    }
    else
    {
        [super dismissViewControllerAnimated:animated completion:nil];
    }
    
}


- (void)onNavigationLeftButtonClicked:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]] || [sender isKindOfClass:[UIBarButtonItem class]])
    {
        // 点击按钮返回
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)onNavigationRightButtonClicked:(id)sender
{
    
}

/**
 *  导航栏左侧显示返回按钮
 */
- (void)showCustomNavigationBackButton
{
    // 导航栏的左边按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icn_back"] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icn_back"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(onNavigationLeftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBack = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil
                                                                                    action:nil];
    
    negativeSpacer.width = - 16;
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,barBack,nil];
}

/**
 *  导航栏左侧显示关闭按钮
 */
- (void)showCustomNavigationCloseButton
{
    // 导航栏的左边按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 51, 41)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"common_btn_navbar_close_nor.png"] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"common_btn_navbar_close_pre.png"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(onNavigationLeftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}


// 显示导航栏左侧的按钮
- (void)showCustomNavigationLeftButtonWithTitle:(NSString *)aTitle image:(UIImage *)aImage hightlightImage:(UIImage *)hImage
{
    // 导航栏的左边按钮
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] init];
    [leftBarButtonItem setStyle:UIBarButtonItemStylePlain];
    [leftBarButtonItem setTarget:self];
    [leftBarButtonItem setAction:@selector(onNavigationLeftButtonClicked:)];
    [leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    if (aTitle.length > 0)
    {
        NSString * titleStr = aTitle;
        if ([titleStr length] < 3)
        {
            titleStr = [NSString stringWithFormat:@"     %@",aTitle];
        }
        
        [leftBarButtonItem setTitle:titleStr];
        
        NSMutableDictionary *titleTextAttributes = [[NSMutableDictionary alloc] init];
        [titleTextAttributes setObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName];
        [titleTextAttributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        [leftBarButtonItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    
    if (aImage)
    {
        //        [leftBarButtonItem setBackgroundImage:aImage forState:UIControlStateNormal barMetrics:UIBarMetricsCompactPrompt];
        [leftBarButtonItem setImage:aImage];
    }
    
    if (hImage)
    {
        //        [leftBarButtonItem setBackgroundImage:hImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsCompactPrompt];
    }
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil
                                                                                    action:nil];
    
    negativeSpacer.width = - 16;
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftBarButtonItem, nil];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

// 显示导航栏右边的按钮
- (void)showCustomNavigationRightButtonWithTitle:(NSString *)aTitle image:(UIImage *)aImage hightlightImage:(UIImage *)hImage
{
    //禁止图片渲染
    aImage = [aImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    hImage = [hImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 导航栏的右边按钮
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] init];
    [rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
    [rightBarButtonItem setTarget:self];
    [rightBarButtonItem setAction:@selector(onNavigationRightButtonClicked:)];
    
    if (aTitle.length > 0 && aImage == nil)
    {
        NSString * titleStr = aTitle;
        if ([titleStr length] < 3)
        {
            titleStr = [NSString stringWithFormat:@"%@     ",aTitle];
        }
        
        [rightBarButtonItem setTintColor:[UIColor whiteColor]];
        [rightBarButtonItem setTitle:titleStr];
        
        NSMutableDictionary *titleTextAttributes = [[NSMutableDictionary alloc] init];
        [titleTextAttributes setObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName];
        //        [titleTextAttributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        [rightBarButtonItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    
    if (aImage != nil)
    {
        if (hImage != nil && aTitle.length == 0)
        {
            UIButton *customButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, aImage.size.width, aImage.size.height)];
            [customButton addTarget:self action:@selector(onNavigationRightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [customButton setBackgroundImage:aImage forState:UIControlStateNormal];
            [customButton setBackgroundImage:hImage forState:UIControlStateSelected];
            
            rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
        }
        else if (hImage == nil && aTitle.length == 0)
        {
            [rightBarButtonItem setImage:aImage];
        }
    }
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil
                                                                                    action:nil];
    
    negativeSpacer.width = - 16;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, rightBarButtonItem, nil];
}

- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)aTitle image:(UIImage *)aImage hightlightImage:(UIImage *)hImage action:(SEL)action
{
    UIBarButtonItem *barButtonItem = nil;
    
    if (aTitle.length > 0 && aImage == nil)
    {
        barButtonItem = [UIBarButtonItem new];
        [barButtonItem setTintColor:[UIColor whiteColor]];
        [barButtonItem setTitle:aTitle];
        barButtonItem.target = self;
        barButtonItem.action = action;
        
        NSMutableDictionary *titleTextAttributes = [[NSMutableDictionary alloc] init];
        [titleTextAttributes setObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName];
        //        [titleTextAttributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        [barButtonItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    
    if (aImage != nil)
    {
        aImage = [aImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        barButtonItem = [UIBarButtonItem new];
        
        if (hImage != nil && aTitle.length == 0)
        {
            hImage = [hImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            UIButton *customButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, aImage.size.width, aImage.size.height)];
            [customButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
            [customButton setBackgroundImage:aImage forState:UIControlStateNormal];
            [customButton setBackgroundImage:hImage forState:UIControlStateSelected];
            
            barButtonItem.customView = customButton;
        }
        else if (hImage == nil && aTitle.length == 0)
        {
            [barButtonItem setImage:aImage];
            barButtonItem.target = self;
            barButtonItem.action = action;
        }
    }
    
    [barButtonItem setStyle:UIBarButtonItemStylePlain];
    
    return barButtonItem;
}

- (void)showCustomNavigationTwoRightButtonWithFirstTitle:(NSString *)firstTitle
                                              firstImage:(UIImage *)firstImage
                                    firstHightlightImage:(UIImage *)firstHightlightImage
                                             firstAction:(SEL)firstAction
                                             secondTitle:(NSString *)secondTitle
                                             secondImage:(UIImage *)secondImage
                                   secondHightlightImage:(UIImage *)secondHightlightImage
                                            secondAction:(SEL)secondAction
{
    UIButton *firstButton = [self navigationBtnWithTitle:firstTitle image:firstImage hightlightImage:firstHightlightImage action:firstAction];
    
    UIButton *secondButton = [self navigationBtnWithTitle:secondTitle image:secondImage hightlightImage:secondHightlightImage action:secondAction];
    secondButton.frame = CGRectMake(firstButton.frame.size.width, secondButton.frame.origin.y, secondButton.frame.size.width, secondButton.frame.size.height);
    
    if (firstButton == nil || secondButton == nil)
    {
        return;
    }
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  firstButton.frame.size.width + secondButton.frame.size.width,
                                                                  firstButton.frame.size.height)];
    [customView addSubview:firstButton];
    [customView addSubview:secondButton];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil
                                                                                    action:nil];
    
    negativeSpacer.width = - 16;
    
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, barButtonItem];
}

- (void)showCustomNavigationTwoLeftButtonWithFirstTitle:(NSString *)firstTitle
                                             firstImage:(UIImage *)firstImage
                                   firstHightlightImage:(UIImage *)firstHightlightImage
                                            firstAction:(SEL)firstAction
                                            secondTitle:(NSString *)secondTitle
                                            secondImage:(UIImage *)secondImage
                                  secondHightlightImage:(UIImage *)secondHightlightImage
                                           secondAction:(SEL)secondAction
{
    UIButton *firstButton = [self navigationBtnWithTitle:firstTitle image:firstImage hightlightImage:firstHightlightImage action:firstAction];
    
    UIButton *secondButton = [self navigationBtnWithTitle:secondTitle image:secondImage hightlightImage:secondHightlightImage action:secondAction];
    secondButton.frame = CGRectMake(firstButton.frame.size.width - 5, secondButton.frame.origin.y, secondButton.frame.size.width, secondButton.frame.size.height);
    [secondButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if (firstButton == nil || secondButton == nil)
    {
        return;
    }
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  firstButton.frame.size.width + secondButton.frame.size.width,
                                                                  firstButton.frame.size.height)];
    [customView addSubview:firstButton];
    [customView addSubview:secondButton];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil
                                                                                    action:nil];
    
    negativeSpacer.width = - 16;
    
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, barButtonItem];
    
}



- (UIButton *)navigationBtnWithTitle:(NSString *)aTitle image:(UIImage *)aImage hightlightImage:(UIImage *)hImage action:(SEL)action
{
    UIButton *btn = nil;
    
    if(aTitle.length > 0)
    {
        btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [btn setTitle:aTitle forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    
    if (aImage != nil)
    {
        aImage = [aImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, aImage.size.width, aImage.size.height)];
        [btn setBackgroundImage:aImage forState:UIControlStateNormal];
        
        if (hImage != nil)
        {
            hImage = [hImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            [btn setBackgroundImage:hImage forState:UIControlStateSelected];
        }
    }
    
    if (action && btn)
    {
        [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
}

@end
