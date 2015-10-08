//
//  NSString+WYString.m
//  0729-－qq
//
//  Created by admin on 15/7/30.
//  Copyright (c) 2015年 wyzc. All rights reserved.
//

#import "NSString+WYString.h"

@implementation NSString (WYString)

-(CGSize)calcSizeWithFont:(UIFont *)font maxWith:(CGFloat)maxWith
{
    NSDictionary *dict=@{NSFontAttributeName:font};
    
    CGSize maxSize=CGSizeMake(maxWith, MAXFLOAT);
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

@end
