//
//  AppDelegate.m
//  NewGuidePages
//
//  Created by 白金星 on 15/12/15.
//  Copyright © 2015年 cn.bjx680. All rights reserved.
//

#import "AppDelegate.h"
#import "JXNavController.h"
#import "JXGuideController.h"
#import "JXTabBarController.h"
#define kScreenSize [UIScreen mainScreen].bounds
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:kScreenSize];

    self.window.rootViewController = [self chooseViewController];
    [self.window makeKeyAndVisible];

    [self saveAppVersion];
    return YES;
}

//选择应该显示的控制器
- (UIViewController *)chooseViewController{


    //判断沙盒和当前版本号是否一致
    if ([[self loadSaveAppVersion] isEqualToString:[self loadAppVersion]]) {
        //一致,显示导航控制器
//        JXTabBarController *nav = [[JXTabBarController alloc]init];
        JXGuideController *guide = [[JXGuideController alloc]init];
        NSLog(@"nav");
        return guide;
    }else{
        //不一致,显示引导页
        JXGuideController *guide = [[JXGuideController alloc]init];

        NSLog(@"VC");
        return guide;

    }



}




//获取沙盒中保存的版本
- (NSString *)loadSaveAppVersion{

    //获取ud对象
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:@"appVersion"];


}

//将当前版本号保存到沙盒中
- (void)saveAppVersion{
   //获取info.plist
    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;
    //获取用户对象
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:dict[@"CFBundleShortVersionString"] forKey:@"appVersion"];



}

//获取当前版本号
- (NSString *)loadAppVersion{

    //获取info.plist
    NSDictionary *dict =[NSBundle mainBundle].infoDictionary;
    NSLog(@"%@",dict[@"CFBundleShortVersionString"]);
    return dict[@"CFBundleShortVersionString"];



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
