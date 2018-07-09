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

/**The container of tabBar buttons*/
@property (nonatomic, strong) UIScrollView                          *scrollView;
/**The array of all tab items */
@property (nonatomic, strong) NSArray                               *tabItemArray;
/**The font of buttons in normal status (default: "normal, 14")*/
@property (nonatomic, assign) UIFont                                *normalTitleFont;
/**The font of buttons in selected status (default: the same with 'normalFont')*/
@property (nonatomic, assign) UIFont                                *currentTitleFont;
/**The title color of buttons in normal status (default: 'blackColor')*/
@property (nonatomic, strong) UIColor                               *normalTitleColor;
/**The title color of buttons in selected status (default: 'orangeColor')*/
@property (nonatomic, strong) UIColor                               *currentTitleColor;
/**The background color of buttons in normal status (default: 'whiteColor')*/
@property (nonatomic, strong) UIColor                               *normalButtonBgColor;
/**The background color of buttons in selected status (default: 'whiteColor')*/
@property (nonatomic, strong) UIColor                               *currentButtonBgColor;
/**The margin between buttons (default: 0)*/
@property (nonatomic, assign) CGFloat                               buttonMargin;
/**The margin between the tab bar's left side and the first button's left side (default: 0)*/
@property (nonatomic, assign) CGFloat                               leftMargin;
/**The margin between the tab bar's right side and the last button's right side (default: the same with 'leftMargin')*/
@property (nonatomic, assign) CGFloat                               rightMargin;
/**The height of tab bar (default: 40, the same with buttons' height)*/
@property (nonatomic, assign) CGFloat                               tabBarHeight;
/**The width of buttons. (default: 100. if 'unifiedWidth' is 'NO', no need to set this property)*/
@property (nonatomic, assign) CGFloat                               buttonWidth;
/**The color of indicator line (default: the same with 'currentColor')*/
@property (nonatomic, strong) UIColor                               *indicatorLineColor;
/**The height of indicator line (default: 1)*/
@property (nonatomic, assign) CGFloat                               indicatorLineHeight;
/**The width of indicator line (default: the same with button's width)*/
@property (nonatomic, assign) CGFloat                               indicatorLineWidth;
/**The indicator line is in the center or not (default: NO)*/
@property (nonatomic, assign, getter=isIndicatorLineCenter) BOOL    indicatorLineCenter;
/**Show indicator line or not (default: 'NO')*/
@property (nonatomic, assign, getter=isShowIndicatorLine) BOOL      showIndicatorLine;
/**The color of bottom line of tab bar (default: 'lightGrayColor')*/
@property (nonatomic, strong) UIColor                               *bottomLineColor;
/**The height of bottom line of tab bar (default: 1)*/
@property (nonatomic, assign) CGFloat                               bottomLineHeight;
/**Show bottom line of tab bar or not (default: 'NO')*/
@property (nonatomic, assign, getter=isShowBottomLine) BOOL         showBottomLine;
/**Each button has the same width or not (default: 'NO'. If it's 'YES', the 'buttonWidth' must be set, default is 100)*/
@property (nonatomic, assign, getter=isUnifiedWidth) CGFloat        unifiedWidth;
/**Has bounces effect or not (default: 'NO')*/
@property (nonatomic, assign, getter=isBounces) CGFloat             bounces;
/**Scroll table view to select tabbar button*/
@property (nonatomic, assign, getter=isFromScrollTable) BOOL        fromScrollTable;

@property (nonatomic, weak) id<DWScrollTabBarDelegate>              delegate;

/**
 * Click a button in the tab bar.
 */
- (void)clickTabButton:(UIButton *)button;
/**
 * Click a button in the tab bar according to a 'index'
 */
- (void)clickButtonAtIndex:(NSInteger)index;

@end
