//
//  AppDelegate+Helper.m
//  XueChu
//
//  Created by eddy on 2018/1/4.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "AppDelegate+Helper.h"
#import "IQKeyboardManager.h"
#import "CustomTaBarController.h"
#import "BaseNavigationController.h"
#import "LoginController.h"

@implementation AppDelegate (Helper)

- (void)configGlobalKeyboardManager
{
    //Enabling keyboard manager
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    //Enabling autoToolbar behaviour. If It is set to NO. You have to manually create UIToolbar for keyboard.
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    
    //Setting toolbar behavious to IQAutoToolbarBySubviews. Set it to IQAutoToolbarByTag to manage previous/next according to UITextField's tag property in increasing order.
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarBySubviews];
    
    //Resign textField if touched outside of UITextField/UITextView.
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
}

- (void)configRootController
{
    [self setUpRootControllerWithIsTaBarController:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessNotification:) name:LOGIN_SERVER_RESPONSE_UI object:nil];
}

- (void)loginSuccessNotification:(NSNotification *)aNotification
{
    [self setUpRootControllerWithIsTaBarController:YES];
}

- (void)setUpRootControllerWithIsTaBarController:(BOOL)isTaBarController
{
    if (isTaBarController)
    {
        CustomTaBarController *rootController = [[CustomTaBarController alloc] init];
        
        [self.window setRootViewController:rootController];
    }
    else
    {
        UINavigationController *rootController = [[UINavigationController alloc] initWithRootViewController:[[LoginController alloc] init]];
        [rootController.navigationBar setTranslucent:NO];
        
        [self.window setRootViewController:rootController];
    }
}

@end
