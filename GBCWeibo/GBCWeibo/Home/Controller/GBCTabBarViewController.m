//
//  GBCTabBarViewController.m
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/25.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCTabBarViewController.h"
#import "GBCHomeNavController.h"
#import "GBCMessageNavController.h"
#import "GBCDiscoverNavController.h"
#import "GBCProfileNavController.h"
#import "GBCWriteNavController.h"
#import "GBCTabBar.h"

@interface GBCTabBarViewController () <GBCTabBarDelegate>

@end

@implementation GBCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GBCHomeNavController *home=[[GBCHomeNavController alloc] init];
    GBCMessageNavController *msg=[[GBCMessageNavController alloc] init];
    GBCDiscoverNavController *discover=[[GBCDiscoverNavController alloc] init];
    GBCProfileNavController *profile=[[GBCProfileNavController alloc] init];
    
    //GBCWriteNavController *write=[[GBCWriteNavController alloc] init];

    self.viewControllers=@[home,msg,discover,profile];
   
    GBCTabBar *tabBar=[[GBCTabBar alloc] init];
    tabBar.GBCDelegate=self;
    //self.tabBar=tabBar;
    [self setValue:tabBar forKey:@"tabBar"];//使用kvc修改
    
}

- (void)tabBarDidAddButtonClicked:(GBCTabBar *)tabBar
{
    GBCWriteNavController *write=[[GBCWriteNavController alloc] init];
    [self presentViewController:write animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
