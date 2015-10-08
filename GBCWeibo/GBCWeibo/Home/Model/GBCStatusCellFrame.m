//
//  GBCStatusCellFrame.m
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/31.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCStatusCellFrame.h"
#import "NSString+WYString.h"


@implementation GBCStatusCellFrame

- (instancetype)init
{
    self=[super init];
    if (self) {
        _imgFrames=[NSMutableArray array];
    }
    return self;
}

- (void)setStatus:(GBCStatus *)status
{
    _status=status;
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
    
    //计算头像view的frame
    int padding=10;
    int headerViewY=padding;
    int headerViewX=padding;
    int headerViewW=40;
    int headerViewH=headerViewW;
    _headerViewFrame=CGRectMake(headerViewX, headerViewY, headerViewW, headerViewH);
    
    //计算screen_name的frame
    int headerButtonX=CGRectGetMaxX(_headerViewFrame)+padding;
    int headerButtonY=headerViewY;
    int headerButtonW=screenW-headerButtonX-padding;
    int headerButtonH=25;
    
    _headerButtonFrame=CGRectMake(headerButtonX, headerButtonY, headerButtonW, headerButtonH);
    
    //计算时间标签的frame
    int timeLblX=headerButtonX;
    int timeLblY=CGRectGetMaxY(_headerButtonFrame)+3;
    int timeLblW=55;
    int timeLblH=12;
    _timelblFrame=CGRectMake(timeLblX, timeLblY, timeLblW, timeLblH);
    
    //计算来源标签的frame
    int sourceLblX=CGRectGetMaxX(_timelblFrame)+padding;
    int sourcrLblY=timeLblY;
    int sourcrLblW=screenW-sourceLblX-padding;
    int sourceLblH=timeLblH;
    _sourceLblFrame=CGRectMake(sourceLblX, sourcrLblY, sourcrLblW, sourceLblH);
    
    //计算正文标签的frame
    int textLblX=headerViewX;
    int textLblY=CGRectGetMaxY(_headerViewFrame)+padding;
    int textLblW=screenW-2*padding;
    CGSize realSize=[_status.text calcSizeWithFont:GBCFONT maxWith:textLblW];
    int textLblH=realSize.height+1;
    _textLblFrame=CGRectMake(textLblX, textLblY, textLblW, textLblH);
    
    //计算图片的frame
    //把字符串类型的数组转换成数组NSArray
    NSString *pics=status.pic_urls;//[{},{},{}]要把这转换成字符串，必须用序列化
    int ip=5;//图片之间的距离
    int imgW=(screenW-2*ip-2*padding)/3;//图片的宽度
    if (pics!=nil) {
        
        NSData *data=[pics dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
        int imgH=imgW;
        int imgY=CGRectGetMaxY(_textLblFrame)+padding;
        for (int i=0; i<arr.count; i++) {
            int row=i/3;
            int col=i%3;
            int x=padding+col*(ip+imgW);
            int y=imgY+row*(ip+imgH);
            CGRect rect=CGRectMake(x, y, imgW, imgH);
            self.rec=rect;
            //valueWithCGRect
            [self.imgFrames addObject:[NSValue valueWithCGRect:rect]];//注意：向数组中添加的只能是对象
        }
    }
    
    NSUInteger cnt=self.imgFrames.count;
    NSUInteger imgTotalH=0;
    if (cnt>0) {
        NSUInteger row=(cnt%3==0)?cnt/3:cnt%3+1;
        imgTotalH=row*(ip+imgW);
    }
        
    //计算cell的高度

    _cellHeight=CGRectGetMaxY(_textLblFrame)+padding;
}

@end
