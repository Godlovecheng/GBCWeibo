//
//  GBCOAuthViewController.m
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/27.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCOAuthViewController.h"
#import "AFNetworking.h"
#import "GBCAccessToken.h"
#import "GBCTabBarViewController.h"

@interface GBCOAuthViewController () <UIWebViewDelegate>
@property(weak,nonatomic) UIWebView *browser;

@end

@implementation GBCOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    
    UIWebView *browser=[[UIWebView alloc] initWithFrame:self.view.bounds];//浏览器webkit
    browser.delegate=self;//成为代理，当收到新浪的消息之后才能知道，要不受到消息之后，咱不知道
    self.browser=browser;
    NSString *str=[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",@"3340158922",@"http://www.wyzc.com"];
    //NSString *s=@"http://www.baidu.com";
    NSURL *url=[NSURL URLWithString:str];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [browser loadRequest:request];//加载网址
    
    [self.view addSubview:browser];
    
    
    // Do any additional setup after loading the view.
}
//在每一次向新浪发送请求之前，会先调用该方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *str=request.URL.absoluteString;
    NSRange range=[str rangeOfString:@"code="];
    
    if (range.length>0) {
        NSLog(@"if");
        NSString *code=[str substringFromIndex:(range.location+range.length)];
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        dict[@"client_id"]=@"3340158922";
        dict[@"client_secret"]=@"b7aa1d64ac8b8505733222f8bd431c16";
        dict[@"grant_type"]=@"authorization_code";
        dict[@"code"]=code;
        dict[@"redirect_uri"]=@"http://www.wyzc.com";
        AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
        [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:dict success:^(AFHTTPRequestOperation *operation, NSDictionary *responseData) {
            
            //将返回回来的token保存起来
            GBCAccessToken *token=[GBCAccessToken accessTokenWithDict:responseData];
            [token save];
            GBCTabBarViewController *tabVc=[[GBCTabBarViewController alloc] init];
            
            [UIApplication sharedApplication].keyWindow.rootViewController=tabVc;
            
            NSLog(@"%@",responseData);
        } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
            NSLog(@"%@",error.localizedDescription);
        }];
        return NO;
    }
    //怎样判断一个字符串中是否包含另外一个字符串"abcd" "ab"
    return YES;//request授权
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
