//
//  GBCStatusCellFrame.h
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/31.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#define GBCFONT [UIFont systemFontOfSize:15]
#import <Foundation/Foundation.h>
#import "GBCStatus.h"

@interface GBCStatusCellFrame : NSObject

/**
 *  头像的Frame
 */
@property(nonatomic,assign,readonly) CGRect headerViewFrame;
/**
 *  screen_name的Frame
 */
@property(nonatomic,assign,readonly) CGRect headerButtonFrame;

/**
 *  时间的Frame
 */
@property(nonatomic,assign,readonly) CGRect timelblFrame;
/**
 *  来源的Frame
 */
@property(nonatomic,assign,readonly) CGRect sourceLblFrame;
/**
 *  正文的Frame
 */
@property(nonatomic,assign,readonly) CGRect textLblFrame;
/**
 *  cell的高度
 */
@property(nonatomic,assign,readonly) CGFloat cellHeight;
/**
 *  模型数据
 */
@property(nonatomic,strong) GBCStatus *status;
/**
 *  保存微博中，每一个图片的frame
 */
@property(nonatomic,strong) NSMutableArray *imgFrames;
@property(nonatomic,assign) CGRect rec;

@end
