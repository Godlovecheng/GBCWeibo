//
//  GBCMessageController.m
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/25.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCMessageNavController.h"
#import "GBCTblViewController.h"

@interface GBCMessageNavController ()

@end

@implementation GBCMessageNavController

- (instancetype)init
{
    GBCTblViewController *tbl=[[GBCTblViewController alloc] init];
    return [super initWithRootViewController:tbl];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarItem.title=@"消息";
    
    [self setGBCTabBar:@"tabbar_message_center" imgSelected:@"tabbar_message_center_selected"];
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
