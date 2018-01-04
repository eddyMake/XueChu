//
//  AppDelegate+Helper.m
//  XueChu
//
//  Created by eddy on 2018/1/4.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "AppDelegate+Helper.h"
#import "IQKeyboardManager.h"

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

@end
