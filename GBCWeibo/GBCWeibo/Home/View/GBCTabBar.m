//
//  GBCTabbar.m
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/26.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCTabBar.h"


@interface GBCTabBar ()
@property(weak,nonatomic) UIButton *addBtn;

@end

@implementation GBCTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        UIButton *addBtn=[[UIButton alloc] init];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:(UIControlStateNormal)];
        [addBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:(UIControlStateNormal)];
        
        [addBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:(UIControlStateHighlighted)];
        [addBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:(UIControlStateHighlighted)];
        
        self.addBtn=addBtn;
        
        [addBtn addTarget:self action:@selector(addButtonClicked) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self addSubview:addBtn];//添加到tabbar
    }
    return self;
}


- (void)addButtonClicked
{
    if ([self.GBCDelegate respondsToSelector:@selector(tabBarDidAddButtonClicked:)]) {
        [self.GBCDelegate tabBarDidAddButtonClicked:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //NSLog(@"%@",self.subviews);
    NSUInteger count=self.subviews.count;
    CGFloat width=self.bounds.size.width/(count-2);
    int y=0;
    int height=self.bounds.size.height;
    int idx=0;
    //思路：如果子控件是UITabBarButton或UIButton类型的，需要设置frame
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            
            if (idx==2) {
                idx++;
                //view.frame=CGRectMake(x, y, width, height);
            }
            CGFloat x=idx*width;
            view.frame=CGRectMake(x, y, width, height);
            idx++;
        }
        if ([view isKindOfClass:NSClassFromString(@"UIButton")])
        {
            CGFloat x=2*width;
            view.frame=CGRectMake(x, y, width, height);
        }

    }
//    for (int i=0; i<count; i++) {
//        int x=i*width;
//        if ([self.subviews[i] isKindOfClass:NSClassFromString(@"UITabBarButton")]&&idx<2)
//        {
//            UIView *view=self.subviews[i];
//            view.frame=CGRectMake(x, y, width, height);
//            idx++;
//        }
//        if ([self.subviews[i] isKindOfClass:NSClassFromString(@"UIButton")]&&idx<2)
//        {
//            x=3*width;
//            UIView *view=self.subviews[i];
//            view.frame=CGRectMake(x , y, width, height);
//        }
//        if ([self.subviews[i] isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            
//        }
//    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
