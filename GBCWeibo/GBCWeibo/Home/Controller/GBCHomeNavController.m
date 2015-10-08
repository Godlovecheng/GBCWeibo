//
//  GBCNavigationViewController.m
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/25.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCHomeNavController.h"
#import "GBCHomeTblViewController.h"


@interface GBCHomeNavController ()

@end

@implementation GBCHomeNavController

- (instancetype)init
{
    GBCHomeTblViewController *homeVc=[[GBCHomeTblViewController alloc] init];
    return [super initWithRootViewController:homeVc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.title=@"首页";
    
    [self setGBCTabBar:@"tabbar_home" imgSelected:@"tabbar_home_selected"];
//    self.tabBarItem.badgeValue=@"10";
//    self.tabBarItem.badgeValue=self.dict[@"status"];
//    NSLog(@"%@",self.dict[@"status"]);
}

- (void)setUnread:(NSDictionary *)dict
{
    NSString *str=dict[@"status"];
    int num=[str intValue];
    if (num) {
        self.tabBarItem.badgeValue=[NSString  stringWithFormat:@"%zd",num];
    }
    else
    {
        self.tabBarItem.badgeValue=nil;
    }
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
