//
//  GBCBaseNavController.m
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/25.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCBaseNavController.h"

@interface GBCBaseNavController ()

@end

@implementation GBCBaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(getUnread) userInfo:nil repeats:YES];
}
- (void)getUnread
{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    GBCAccessToken *token=[GBCAccessToken read];
    params[@"access_token"]=token.access_token;
    params[@"uid"]=token.uid;
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation * operation, NSDictionary * responseData)
     {
         [self setUnread:responseData];
         //_dict=responseData;
         //self.tabBarItem.badgeValue=responseData[@"status"];
     }
     failure:^(AFHTTPRequestOperation * operation, NSError * error) {
         
     }];
}

- (void)setUnread:(NSDictionary *)dict
{
    
}

- (void)setGBCTabBar:(NSString *)imgNormal imgSelected:(NSString *)imgSelected
{
    //设置字体的颜色
    NSDictionary *dictSelected=@{NSForegroundColorAttributeName:[UIColor colorWithRed:208/255.0 green:126/255.0 blue:0 alpha:1]};
    [self.tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
    NSDictionary *dictNormal=@{NSForegroundColorAttributeName:[UIColor blackColor]};
    [self.tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    
    //
    self.tabBarItem.image=[UIImage imageNamed:imgNormal];
    UIImage *img=[UIImage imageNamed:imgSelected];
    img=[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage=img;
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
