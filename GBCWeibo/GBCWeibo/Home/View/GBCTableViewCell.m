//
//  GBCTableViewCell.m
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/31.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCTableViewCell.h"
#import "GBCStatusCellFrame.h"
#import "UIImageView+WebCache.h"
#import "GBCStatus.h"
#import "GBCUser.h"

@interface GBCTableViewCell ()
/**
 *  显示头像
 */
@property(nonatomic,weak) UIImageView *headerView;
/**
 *  显示screen_name
 */
@property(nonatomic,weak) UIButton *headerButton;
/**
 *  显示时间
 */
@property(nonatomic,weak) UILabel *timelbl;
/**
 *  显示来源
 */
@property(nonatomic,weak) UILabel *sourceLbl;
/**
 *  显示正文
 */
@property(nonatomic,weak) UILabel *textLbl;

@end

@implementation GBCTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//- (instancetype)initWithFrame:(CGRect)frame
{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //创建头像
        UIImageView *headerView=[[UIImageView alloc]init];
        [self.contentView addSubview:headerView];
        self.headerView=headerView;
        
        //创建screen_name按钮
        UIButton *headerButton=[[UIButton alloc] init];
        headerButton.titleLabel.font=GBCFONT;//[UIFont systemFontOfSize:13];
        [headerButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.contentView addSubview:headerButton];
        headerButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        self.headerButton=headerButton;
        
        //创建时间标签
        UILabel *timeLbl=[[UILabel alloc] init];
        timeLbl.font=[UIFont systemFontOfSize:10];
        timeLbl.textColor=[UIColor orangeColor];
        [self.contentView addSubview:timeLbl];
        self.timelbl=timeLbl;
        
        //创建来源标签
        UILabel *sourceLbl=[[UILabel alloc] init];
        sourceLbl.font=[UIFont systemFontOfSize:10];
        sourceLbl.textColor=[UIColor grayColor];
        [self.contentView addSubview:sourceLbl];
        self.sourceLbl=sourceLbl;
        
        //创建显示正文的标签
        UILabel *textLbl=[[UILabel alloc] init];
        textLbl.font=GBCFONT;//[UIFont systemFontOfSize:8];
        textLbl.textColor=[UIColor grayColor];
        [self.contentView addSubview:textLbl];
        textLbl.numberOfLines=0;
        self.textLbl=textLbl;
    }
    return self;
}



- (void)setStatusCellFrame:(GBCStatusCellFrame *)statusCellFrame
{
    _statusCellFrame=statusCellFrame;
    //设置headerview的frame
    GBCStatus *status=statusCellFrame.status;
    GBCUser *user=status.user;
    self.headerView.frame=statusCellFrame.headerViewFrame;
    NSURL *url=[NSURL URLWithString:user.profile_image_url];
    [self.headerView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    //设置headerButton的frame
    self.headerButton.frame=statusCellFrame.headerButtonFrame;
    [self.headerButton setTitle:user.screen_name forState:(UIControlStateNormal)];
    
    self.timelbl.frame=statusCellFrame.timelblFrame;
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"EEE MMM d HH:mm:ss Z yyyy";//hh HH
    formatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    //formatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate=[formatter dateFromString:status.created_at];
    NSDate *curDate=[NSDate date];
    int num=[curDate timeIntervalSinceDate:createDate]/60;
    NSString *numStr;
    if (num<60) {
        numStr=[NSString stringWithFormat:@"%d分钟之前",num];
    }
    else if (num<3600)
    {
        num=num/60;
        numStr=[NSString stringWithFormat:@"%d小时之前",num];
    }
    else
    {
        numStr=@"很久以前";
    }
    self.timelbl.text=numStr;
    
    //设置来源
    self.sourceLbl.frame=statusCellFrame.sourceLblFrame;
    NSString *str=status.source;
    NSRange start=[str rangeOfString:@">"];
    NSRange end=[str rangeOfString:@"</a>"];
    long length=end.location-start.location;
    NSRange range={start.location+1,length-1};
    self.sourceLbl.text=[str substringWithRange:range];
    
    //设置正文
    self.textLbl.text=status.text;
    self.textLbl.frame=statusCellFrame.textLblFrame;
    
    //设置图片
    NSMutableArray *arrFrames=statusCellFrame.imgFrames;
    NSString *pics=status.pic_urls;//"[{},{}]"
    if (pics!=nil)
    {
        NSData *data=[pics dataUsingEncoding:NSUTF8StringEncoding];//把字符串转换成二进制数据
        NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        for (int i=0; i<arr.count; i++)
        {
            CGRect rect=[arrFrames[i] CGRectValue];//从数组中获取对应图片的frame，并转换成结构体
            UIImageView *imgView=[[UIImageView alloc] initWithFrame:rect];
            NSDictionary *dict=arr[i];//thumbnail_pic
            NSURL *url=[NSURL URLWithString:dict[@"thumbnail_pic"]];
            [imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"avatar_default"]];
            //[self.contentView addSubview:imgView];
        }
    }



}
/**
 *  类构造函数
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"status";
    GBCTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[GBCTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    return cell;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
