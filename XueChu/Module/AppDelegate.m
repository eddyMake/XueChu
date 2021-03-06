//
//  AppDelegate.m
//  XueChu
//
//  Created by eddy on 2018/1/2.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomTaBarController.h"
#import "BaseNavigationController.h"
#import "LoginController.h"
#import "AppDelegate+Helper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"%@",SERVER_DATA_B);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    [self registerNotifications];
    [self configGlobalKeyboardManager];
    [self setUpRootControllerWithIsTaBarController:NO];
    
    return YES;
}

- (void)registerNotifications
{
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

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
