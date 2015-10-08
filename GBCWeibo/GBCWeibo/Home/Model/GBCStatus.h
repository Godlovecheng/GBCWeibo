//
//  GBCStatus.h
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/29.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBCUser.h"


@interface GBCStatus : NSObject
/**
 *  微博ID
 */
@property (nonatomic, assign) long long   sid;
/**
 *  创建时间
 */
@property (nonatomic,copy)NSString *created_at;
/**
 *  微博的信息内容
 */
@property (nonatomic, copy) NSString * text;
/**
 *  微博的来源
 */
@property (nonatomic,copy)NSString *source;
/**
 *  微博的发布者
 */
@property(nonatomic,strong)GBCUser *user;
/**
 *  微博的配图ID-字符串类型的数组 就相当于"[]"
 */
@property(nonatomic,copy)NSString *pic_urls;
/**
 *  转发数
 */
@property(nonatomic,assign) int reposts_count;
/**
 *  评论数
 */
@property(nonatomic,assign) int comments_count;
/**
 *  表态数
 */
@property(nonatomic,assign) int attitudes_count;

//@property (nonatomic, copy) NSString * profileimg;


@end
