//
//  DWScrollTabBar.h
//  DWScrollTabBarDemo
//
//  Created by jiadawei on 16/03/2017.
//  Copyright © 2017 david. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DWScrollTabBar;

@protocol DWScrollTabBarDelegate <NSObject>
/*
 * 点击选项卡按钮
 */
- (BOOL)tabBar:(DWScrollTabBar *)tabBar didClickTabButton:(UIButton *)tabBarButton;

@end

/**
 知识库分类可滚动tabBar
 */
@interface DWScrollTabBar : UIView

/**存放tabBar按钮*/
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray                               *tabItemArray;
/**正常字体*/
@property (nonatomic, assign) UIFont                                *normalFont;
/**选中字体*/
@property (nonatomic, assign) UIFont                                *currentFont;
/**正常标题颜色*/
@property (nonatomic, strong) UIColor                               *normalColor;
/**当前标题颜色*/
@property (nonatomic, strong) UIColor                               *currentColor;
/**正常背景颜色*/
@property (nonatomic, strong) UIColor                               *normalBgColor;
/**当前背景颜色*/
@property (nonatomic, strong) UIColor                               *currentBgColor;
/**按钮间距*/
@property (nonatomic, assign) CGFloat                               buttonMargin;
/**左侧间距*/
@property (nonatomic, assign) CGFloat                               leftMargin;
/**右侧间距*/
@property (nonatomic, assign) CGFloat                               rightMargin;
/**tabBar高度(默认40)*/
@property (nonatomic, assign) CGFloat                               tabBarHeight;
/**按钮宽度(默认100)*/
@property (nonatomic, assign) CGFloat                               buttonWidth;
/**指示条颜色*/
@property (nonatomic, strong) UIColor                               *indicatorLineColor;
/**指示线高度(默认1)*/
@property (nonatomic, assign) CGFloat                               indicatorLineHeight;
/**指示线宽度(默认按钮宽度)*/
@property (nonatomic, assign) CGFloat                               indicatorLineWidth;
/**指示线居中(默认可不设置)*/
@property (nonatomic, assign, getter=isIndicatorLineCenter) BOOL    indicatorLineCenter;
/**是否显示指示线(默认不显示)*/
@property (nonatomic, assign, getter=isShowIndicatorLine) BOOL      showIndicatorLine;
/*底部分割线颜色*/
@property (nonatomic, strong) UIColor                               *bottomLineColor;
/**底部分割线高度(默认1)*/
@property (nonatomic, assign) CGFloat                               bottomLineHeight;
/**是否显示底部分割线(默认不显示)*/
@property (nonatomic, assign, getter=isShowBottomLine) BOOL         showBottomLine;
/**是否使用统一宽度*/
@property (nonatomic, assign, getter=isUnifiedWidth) CGFloat        unifiedWidth;
/**是否有弹簧效果*/
@property (nonatomic, assign, getter=isBounces) CGFloat             bounces;
/**滚动列表来选中tabBar上的按钮*/
@property (nonatomic, assign, getter=isFromScrollTable) BOOL        fromScrollTable;

@property (nonatomic, weak) id<DWScrollTabBarDelegate>              delegate;

/**
 * 点击tabBarButton
 */
- (void)clickTabButton:(UIButton *)button;
/**
 * 根据索引点击tabBarButton上的按钮
 */
- (void)clickButtonAtIndex:(NSInteger)index;

@end
