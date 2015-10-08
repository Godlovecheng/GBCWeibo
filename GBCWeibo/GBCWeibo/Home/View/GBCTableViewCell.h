//
//  GBCTableViewCell.h
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/31.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  GBCStatusCellFrame;

@interface GBCTableViewCell : UITableViewCell
@property(nonatomic,strong) GBCStatusCellFrame *statusCellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end














