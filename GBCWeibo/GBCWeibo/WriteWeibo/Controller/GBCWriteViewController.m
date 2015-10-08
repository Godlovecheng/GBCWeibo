//
//  GBCWwiteViewController.m
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/26.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCWriteViewController.h"

@interface GBCWriteViewController ()

@end

@implementation GBCWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(btnCancel)];
    self.navigationItem.leftBarButtonItem=item;
}

- (void)btnCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
