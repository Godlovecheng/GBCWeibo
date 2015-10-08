//
//  GBCWriteNavController.m
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/26.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCWriteNavController.h"
#import "GBCWriteViewController.h"

@interface GBCWriteNavController ()

@end

@implementation GBCWriteNavController

- (instancetype)init
{
    GBCWriteViewController *write=[[GBCWriteViewController alloc] init];
    return [super initWithRootViewController:write];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
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
