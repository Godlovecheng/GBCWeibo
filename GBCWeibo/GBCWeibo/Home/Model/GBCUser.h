//
//  GBCUser.h
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/31.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBCUser : NSObject
@property(nonatomic,assign) long long uid;
@property (nonatomic,copy)NSString *profile_image_url;
@property (nonatomic,copy)NSString *screen_name;


@end
