//
//  GBCAccessToken.m
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/28.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#define GBCPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"gbcaccess_token.data"]
#import "GBCAccessToken.h"

@implementation GBCAccessToken

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)accessTokenWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self=[super init]) {
        self.access_token=[decoder decodeObjectForKey:@"access_token"];
        self.expires_in=[decoder decodeObjectForKey:@"expires_in"];
        self.uid=[decoder decodeObjectForKey:@"uid"];
    }
    return self;
}
/**
 *  向沙盒中存的时候自动调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
}

/**
 *  把对象保存到沙盒
 */
- (void)save
{
    //NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"gbcaccess_token.data"];
    [NSKeyedArchiver archiveRootObject:self toFile:GBCPath];
}
/**
 *  读取沙盒中的文件，然后再还原成一个对象
 */
+ (instancetype)read
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:GBCPath];
}

@end
