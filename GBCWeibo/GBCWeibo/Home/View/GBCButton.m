//
//  GBCButton.m
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/26.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCButton.h"

@interface GBCButton ()
@property(assign,nonatomic) CGFloat titleWidth;

@end

@implementation GBCButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.titleLabel.font=[UIFont boldSystemFontOfSize:22];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x=CGRectGetMinX(self.imageView.frame);
    self.titleLabel.frame=CGRectMake(x, self.titleLabel.frame.origin.y, self.titleLabel.bounds.size.width, self.titleLabel.bounds.size.height);
    
    
    x=CGRectGetMaxX(self.titleLabel.frame)+5;
    self.imageView.frame=CGRectMake(x, self.imageView.frame.origin.y, self.imageView.bounds.size.width, self.imageView.bounds.size.height);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];//自适应大小 按钮宽度＝文字宽度＋图片的宽度
}
//为了当网络不好时，名字没显示出来，但是后面的向下的三角能显示出来
- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}

/*
//重新设置标题的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    //self.titlelabel
    CGFloat width=self.bounds.size.width;
    CGFloat height=self.bounds.size.height;
    
    UIImage *img=self.currentImage;//获取右边显示的图片
    NSString *title=self.titleLabel.text;
    NSDictionary *dict=@{NSForegroundColorAttributeName:[UIFont systemFontOfSize:15]};
    CGSize realSize=[title sizeWithAttributes:dict];
    
    CGFloat titleWidth=realSize.width;
    
    //CGFloat titleWidth=width-6-img.size.width;
    
    self.titleWidth=titleWidth;
    NSLog(@"%f",titleWidth);
    
    return CGRectMake(2, 2, titleWidth, height-4);
}
 */


//重新设置图片的frame
//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    //self.imageView
//    UIImage *img=self.currentImage;//获取右边显示的图片
//    
//    CGFloat x=self.titleWidth+2;
//    
//    //CGFloat x=self.bounds.size.width-2-img.size.width;
//    CGFloat y=0;
//    CGFloat height=self.bounds.size.height;
//    return CGRectMake(x, y, img.size.width, height);
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
