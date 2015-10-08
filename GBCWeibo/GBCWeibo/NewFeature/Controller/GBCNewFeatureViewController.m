//
//  GBCNewFeatureViewController.m
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/27.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCNewFeatureViewController.h"
#import "GBCTabBarViewController.h"
#import "GBCAccessToken.h"
#import "GBCOAuthViewController.h"



@interface GBCNewFeatureViewController () <UIScrollViewDelegate>
@property(weak,nonatomic) UIPageControl *pageControl;

@end

@implementation GBCNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    scroll.delegate=self;
    [self.view addSubview:scroll];
    scroll.bounces=NO;
    //UIImage *img;
    int width=self.view.bounds.size.width;
    int height=self.view.bounds.size.height;
    for (int i=1; i<5; i++) {
        int x=(i-1)*width;
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
        
        NSString *file=[NSString stringWithFormat:@"new_feature_%d",i];
        imgView.image=[UIImage imageNamed:file];
        [scroll addSubview:imgView];
        
        if (i==4) {
            [self setForeImage:imgView];
            [self enterWb:imgView];
        }

    }
    scroll.pagingEnabled=YES;
    scroll.contentSize=CGSizeMake(4*width, height);
    scroll.showsHorizontalScrollIndicator=NO;
    //scroll.showsVerticalScrollIndicator=NO;
    
    [self createPageControl];
    // Do any additional setup after loading the view.
}

- (void)createPageControl
{
    UIPageControl *control=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.pageControl=control;
    [self.view addSubview:control];
    control.numberOfPages=4;
    
    control.pageIndicatorTintColor=[UIColor grayColor];
    control.currentPageIndicatorTintColor=[UIColor redColor];
    CGFloat x=self.view.bounds.size.width*0.5;
    CGFloat y=self.view.bounds.size.height-50;
    control.center=CGPointMake(x, y);
    //control.userActivity=NO;
    control.userInteractionEnabled=NO;
}

- (void)setForeImage:(UIImageView *)imgView
{
    imgView.userInteractionEnabled=YES;
    
    UIButton *shareBtn=[[UIButton alloc] init];
    CGFloat y=self.view.bounds.size.height-150;
    CGFloat x=self.view.bounds.size.width*0.5;
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:(UIControlStateNormal)];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:(UIControlStateSelected)];
    UIImage *img=shareBtn.currentImage;
    [shareBtn setTitle:@"分享微博" forState:(UIControlStateNormal)];
    [shareBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    shareBtn.frame=CGRectMake(0 , y, 150, img.size.height);
    shareBtn.center=CGPointMake(x , y);
    [imgView addSubview:shareBtn];
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)shareBtnClick:(UIButton *)shareBtn
{
    shareBtn.selected=!shareBtn.selected;
}

- (void)enterWb:(UIImageView *)imgView
{
    
    UIButton *enterBtn=[[UIButton alloc] init];
    [imgView addSubview:enterBtn];
    [enterBtn setTitle:@"进入微博" forState:(UIControlStateNormal)];
    [enterBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    CGFloat y=self.view.bounds.size.height-100;
    enterBtn.frame=CGRectMake(0, y, 105, 35);
    enterBtn.center=CGPointMake(self.view.bounds.size.width*0.5, y);
    [enterBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:(UIControlStateNormal)];
    [enterBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:(UIControlStateHighlighted)];
    
    [enterBtn addTarget:self action:@selector(enterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)enterBtnClick
{
    
    GBCAccessToken *token=[GBCAccessToken read];
    UIWindow *keyWindow=[UIApplication sharedApplication].keyWindow;
    //NSLog(@"%@",keyWindow);
    if (token==nil) {
        GBCOAuthViewController *oauth=[[GBCOAuthViewController alloc] init];
        keyWindow.rootViewController=oauth;
        
    }
    else
    {
        GBCTabBarViewController *tabVc=[[GBCTabBarViewController alloc] init];
        keyWindow.rootViewController=tabVc;
        //NSLog(@"aa");
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offSet=scrollView.contentOffset;
    int page=(offSet.x+=self.view.bounds.size.width*0.5)/self.view.bounds.size.width;
    self.pageControl.currentPage=page;
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
