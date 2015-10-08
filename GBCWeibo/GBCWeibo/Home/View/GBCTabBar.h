//
//  GBCTabbar.h
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/26.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GBCTabBar;

@protocol  GBCTabBarDelegate  <NSObject>
- (void)tabBarDidAddButtonClicked:(GBCTabBar *)tabBar;

@end

@interface GBCTabBar : UITabBar
@property(weak,nonatomic) id<GBCTabBarDelegate> GBCDelegate;

@end
