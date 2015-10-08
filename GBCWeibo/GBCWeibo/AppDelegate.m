//
//  AppDelegate.m
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/25.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "AppDelegate.h"
#import "GBCTabBarViewController.h"
#import "GBCNewFeatureViewController.h"
#import "GBCOAuthViewController.h"
#import "GBCAccessToken.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *oldVersion=[defaults stringForKey:@"version"];
    NSDictionary *dict=[NSBundle mainBundle].infoDictionary;//专门用来读取项目的info.plist文件
    //NSLog(@"%@",dict);
    NSString *currentVersion=dict[@"CFBundleVersion"];
    //NSLog(@"%@",currentVersion);
    if (oldVersion==nil||![oldVersion isEqualToString:currentVersion])
    {//如果是第一次安装或者现在的2个版本不一样，需要显示新特性
        GBCNewFeatureViewController *feature=[[GBCNewFeatureViewController alloc] init];
        self.window.rootViewController=feature;
        [defaults setObject:currentVersion forKey:@"version"];//注意，必须保存现在的版本
    }
    else
    {
        GBCAccessToken *token=[GBCAccessToken read];
        if (token==nil) {
            GBCOAuthViewController *oauth=[[GBCOAuthViewController alloc] init];
            self.window.rootViewController=oauth;
        }
        else
        {
            GBCTabBarViewController *tabVc=[[GBCTabBarViewController alloc] init];
            self.window.rootViewController=tabVc;
        }

    }
//    else
//    {
    
    /*
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *oldVersion=[defaults stringForKey:@"version"];
    NSDictionary *dict=[NSBundle mainBundle].infoDictionary;//专门用来读取项目的info.plist文件
    //NSLog(@"%@",dict);
    NSString *currentVersion=dict[@"CFBundleVersion"];
    NSLog(@"%@",currentVersion);
    if (oldVersion==nil||![oldVersion isEqualToString:currentVersion]) {//如果是第一次安装或者现在的2个版本不一样，需要显示新特性
        GBCNewFeatureViewController *feature=[[GBCNewFeatureViewController alloc] init];
        self.window.rootViewController=feature;
        [defaults setObject:currentVersion forKey:@"version"];//注意，必须保存现在的版本
     */
//    }else
//    {
//        GBCTabBarViewController *tabVc=[[GBCTabBarViewController alloc] init];
//        self.window.rootViewController=tabVc;

//    }
    
//    GBCTabBarViewController *tabVc=[[GBCTabBarViewController alloc] init];
//    self.window.rootViewController=tabVc;
    [self.window makeKeyAndVisible];
    
    
    /*
     
     self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
     
    //首页
    UIViewController *home=[[UIViewController alloc] init];
    home.view.backgroundColor=[UIColor redColor];
    
//    home.tabBarItem.title=@"首页";//208 126 0
//    home.navigationItem.title=@"首页";
    home.title=@"首页";
    
    //NSDictionary *dict=@{NSForegroundColorAttributeName:[UIColor colorWithRed:208/255.0 green:125/255.0 blue:0 alpha:1]};
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName]=[UIColor colorWithRed:208/255.0 green:126/255.0 blue:0 alpha:1];
    
    [home.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    home.tabBarItem.image=[UIImage imageNamed:@"tabbar_home"];
    UIImage *homeImg=[UIImage imageNamed:@"tabbar_home_selected"];
    homeImg=[homeImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//告诉tabbar，不要再渲染图片了
    home.tabBarItem.selectedImage=homeImg;
    //home.tabBarItem.selectedImage=[UIImage imageNamed:@"tabbar_home_selected"];//当把图片放入tabbar中，就自动将其渲染成蓝色
    
    //消息
    UIViewController *message=[[UIViewController alloc] init];
    message.view.backgroundColor=[UIColor blueColor];
//    message.tabBarItem.title=@"消息";
//    message.navigationItem.title=@"消息";
    message.title=@"消息";
    [message.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    message.tabBarItem.image=[UIImage imageNamed:@"tabbar_message_center"];
    UIImage *messageImg=[UIImage imageNamed:@"tabbar_message_center_selected"];
    messageImg=[messageImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    message.tabBarItem.selectedImage=messageImg;
    
    //发现
    UIViewController *discover=[[UIViewController alloc] init];
    discover.view.backgroundColor=[UIColor greenColor];
//    discover.tabBarItem.title=@"发现";
//    discover.navigationItem.title=@"发现";
    discover.title=@"发现";
    [discover.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    discover.tabBarItem.image=[UIImage imageNamed:@"tabbar_discover"];
    UIImage *discoverImg=[UIImage imageNamed:@"tabbar_discover_selected"];
    discoverImg=[discoverImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    discover.tabBarItem.selectedImage=discoverImg;
    
    
    //我
    UIViewController *profile=[[UIViewController alloc] init];
    profile.view.backgroundColor=[UIColor grayColor];
    profile.tabBarItem.title=@"我";
    profile.navigationItem.title=@"我";
    //profile.title=@"我";
    [profile.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    profile.tabBarItem.image=[UIImage imageNamed:@"tabbar_profile"];
    UIImage *profileImg=[UIImage imageNamed:@"tabbar_profile_selected"];
    profileImg=[profileImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    profile.tabBarItem.selectedImage=profileImg;
    
    
    //首页导航控制器
    UINavigationController *homeNav=[[UINavigationController alloc] initWithRootViewController:home];
    //消息导航控制器
    UINavigationController *messageNav=[[UINavigationController alloc] initWithRootViewController:message];
    //发现导航控制器
    UINavigationController *discoverNav=[[UINavigationController alloc] initWithRootViewController:discover];
    //我导航控制器
    UINavigationController *profileNav=[[UINavigationController alloc] initWithRootViewController:profile];
    
    
    
    
    UITabBarController *tabVc=[[UITabBarController alloc] init];
    tabVc.viewControllers=@[homeNav,messageNav,discoverNav,profileNav];
    
    self.window.rootViewController=tabVc;
    [self.window makeKeyAndVisible];
    */
    
    
    
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
