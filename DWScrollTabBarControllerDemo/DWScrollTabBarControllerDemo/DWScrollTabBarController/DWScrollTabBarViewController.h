//
//  DWScrollTabBarViewController.h
//  DWScrollTabBarDemo
//
//  Created by jiadawei on 16/03/2017.
//  Copyright © 2017 david. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWScrollTabBar.h"

@interface DWScrollTabBarViewController : UIViewController <DWScrollTabBarDelegate, UIScrollViewDelegate>

/**顶部tabBar*/
@property (nonatomic, strong) DWScrollTabBar                        *scrollTabBar;
/**主视图-存放各个列表*/
@property (nonatomic, strong) UIScrollView                          *scrollView;
/**分类对象数组*/
@property (nonatomic, strong) NSArray                               *typesArray;
/**列表数组*/
@property (nonatomic, strong) NSMutableArray                        *tableViewArray;
/**当前页索引*/
@property (nonatomic, assign) NSInteger                             currentPage;
/**正常标题颜色*/
@property (nonatomic, strong) UIColor                               *normalColor;
/**当前标题颜色*/
@property (nonatomic, strong) UIColor                               *currentColor;
/**正常背景颜色*/
@property (nonatomic, strong) UIColor                               *normalBgColor;
/**当前背景颜色*/
@property (nonatomic, strong) UIColor                               *currentBgColor;
/**tabBar背景颜色(默认灰色)*/
@property (nonatomic, strong) UIColor                               *tabBarBgColor;
/**指示条颜色*/
@property (nonatomic, strong) UIColor                               *lineColor;
/**按钮间距*/
@property (nonatomic, assign) CGFloat                               margin;
/**左侧间距*/
@property (nonatomic, assign) CGFloat                               leftMargin;
/**右侧间距(默认和左侧间距一样)*/
@property (nonatomic, assign) CGFloat                               rightMargin;
/**指示线高度(默认1)*/
@property (nonatomic, assign) CGFloat                               lineHeight;
/**指示线宽度(默认按钮宽度)*/
@property (nonatomic, assign) CGFloat                               lineWidth;
/**指示线居中(默认)*/
@property (nonatomic, assign, getter=isLineCenter) BOOL             lineCenter;
/**是否显示指示线(默认不显示)*/
@property (nonatomic, assign, getter=isShowLine) BOOL               showLine;
/**tabBar高度(默认40)*/
@property (nonatomic, assign) CGFloat                               tabBarHeight;
/**按钮宽度(默认100)*/
@property (nonatomic, assign) CGFloat                               buttonWidth;
/**是否使用统一宽度*/
@property (nonatomic, assign, getter=isUnifiedWidth) CGFloat        unifiedWidth;
/**是否有弹簧效果*/
@property (nonatomic, assign, getter=isBounces) CGFloat             bounces;

@end
