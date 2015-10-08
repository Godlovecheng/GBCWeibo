//
//  GBCSearchBar.m
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/26.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCSearchBar.h"

@interface GBCSearchBar ()
//@property(weak,nonatomic) UIImageView *searchView;

@end

@implementation GBCSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        /*
//        UIImage *img=[UIImage imageNamed:@"searchbar_textfield_search_icon"];
//        UIImageView *imgView=[[UIImageView alloc] initWithImage:img];
//        self.searchView=
         */
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect=self.leftView.frame;
    self.leftView.frame=CGRectMake(rect.origin.x+5, rect.origin.y, rect.size.width, rect.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
