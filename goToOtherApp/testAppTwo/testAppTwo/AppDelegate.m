//
//  AppDelegate.m
//  testAppTwo
//
//  Created by 千落 on 15/2/6.
//  Copyright (c) 2015年 千落. All rights reserved.
//

#import "AppDelegate.h"
#import "APPViewController.h"
#define HEIGHT [UIScreen mainScreen].applicationFrame.size.height
#define WIDTH [UIScreen mainScreen].applicationFrame.size.width

@interface AppDelegate ()
@property (nonatomic, strong) UILabel *testLabel;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    APPViewController *view = [[APPViewController alloc] init];
    self.window.rootViewController = view;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

//接受其他APP传过来的值
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSString *itemId = [[url query] substringFromIndex:[[url query] rangeOfString:@"name="].location+5];
    NSLog(@"itemId :%@",itemId);
    
    self.testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT/4 - 20)];
    self.testLabel.font = [UIFont systemFontOfSize:50];
    self.testLabel.textColor = [UIColor whiteColor];
    self.testLabel.backgroundColor = [UIColor magentaColor];
    self.testLabel.numberOfLines = 0;
    self.testLabel.text = itemId;
    
    [self.window addSubview:self.testLabel];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
