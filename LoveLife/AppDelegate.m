//
//  AppDelegate.m
//  LoveLife
//
//  Created by 王一成 on 15/12/29.
//  Copyright © 2015年 王一成. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBar.h"
#import "GuideViewPage.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"
//支持qq,weixin,sina
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"

@interface AppDelegate ()
{
    MyTabBar *myTabbar;
    GuideViewPage *_guidePage;

}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //实例化
    
    
    myTabbar = [[MyTabBar alloc]init];
    
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    
    MMDrawerController *drawerVC = [[MMDrawerController alloc] initWithCenterViewController:myTabbar leftDrawerViewController:leftVC];
    
    //设置抽屉打开和关闭的模式
    
    drawerVC.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    
    drawerVC.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    //设置左页面打开之后的宽度
    drawerVC.maximumLeftDrawerWidth = SCREEN_W - 100;
    
    
    
    
    self.window.rootViewController = drawerVC;
#pragma warning //第二种方式改变状态栏的颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    [self.window makeKeyWindow];
    //添加引导页
    [self creatGuidePage];
    //注册友盟分享
    [self addUMshare];
    return YES;
}

#pragma mark -友盟分享
-(void)addUMshare
{
    //注册友盟分享

    [UMSocialData setAppKey:@"566cf4ebe0f55a23e5007be9"];
    //设置qq。。
    [UMSocialQQHandler setQQWithAppId:@"1104908293" appKey:@"MnGtpPN5AiB6MNvj" url:nil];
    //微信
    [UMSocialWechatHandler setWXAppId:@"wx12b249bcbf753e87" appSecret:@"0a9cd00c48ee47a9b23119086bcd3b30" url:nil];
    //打开微博sso开关
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    //隐藏未安装的客户端（主要针对qq和微信）
    //主要针对qq和微信
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatTimeline,UMShareToWechatSession]];
    
}

-(void)creatGuidePage
{
    if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"isRun"]boolValue]) {
        
        _guidePage = [[GuideViewPage alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H+64) ImageAray:@[@"welcome1",@"welcome2",@"welcome3"]];

        [myTabbar.view addSubview:_guidePage];
        //第一次完成后记录
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isRun"];
    }
    
    [_guidePage.GoInButton addTarget:self action:@selector(goin) forControlEvents:UIControlEventTouchUpInside];
}

-(void)goin
{
    [_guidePage removeFromSuperview];
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
