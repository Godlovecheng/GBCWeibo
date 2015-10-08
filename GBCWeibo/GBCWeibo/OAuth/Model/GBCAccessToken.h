//
//  GBCAccessToken.h
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/28.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBCAccessToken : NSObject <NSCoding>
@property (copy,nonatomic)NSString *access_token;
@property(copy,nonatomic) NSString *expires_in;
@property(copy,nonatomic) NSString *remind_in;
@property(copy,nonatomic) NSString *uid;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)accessTokenWithDict:(NSDictionary *)dict;

/**
 *  把对象保存到沙盒
 */
- (void)save;
/**
 *  读取沙盒中的文件，然后再还原成一个对象
 */
+ (instancetype)read;

@end
