//
//  DWScrollTabBarController.h
//  DWScrollTabBarControllerDemo
//
//  Created by jiadawei on 06/04/2017.
//  Copyright © 2017 david. All rights reserved.
//
// version: 1.0.2

#import <UIKit/UIKit.h>
#import "DWScrollTabBar.h"

@interface DWScrollTabBarController : UIViewController <DWScrollTabBarDelegate, UIScrollViewDelegate>

/**The tab bar on the top*/
@property (nonatomic, strong) DWScrollTabBar                        *scrollTabBar;
/**The main view(store all sub tableviews)*/
@property (nonatomic, strong) UIScrollView                          *scrollView;
/**The array of all type objects*/
@property (nonatomic, strong) NSArray                               *typesArray;
/**The array of all sub tableviews*/
@property (nonatomic, strong) NSMutableArray                        *tableViewArray;
/**The index of current page*/
@property (nonatomic, assign) NSInteger                             currentPage;
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
/**The background color of tab bar (default: whiteColor)*/
@property (nonatomic, strong) UIColor                               *tabBarBgColor;
/**The height of tab bar (default: 40, the same with buttons' height)*/
@property (nonatomic, assign) CGFloat                               tabBarHeight;
/**The margin between tab bar and tableview (default: 0)*/
@property (nonatomic, assign) CGFloat                               viewMargin;
/**Show view margin or not (default: 'NO')*/
@property (nonatomic, assign, getter=isShowViewMargin) BOOL         showViewMargin;
/**The margin between buttons (default: 0)*/
@property (nonatomic, assign) CGFloat                               buttonMargin;
/**The margin between the tab bar's left side and the first button's left side (default: 0)*/
@property (nonatomic, assign) CGFloat                               leftMargin;
/**The margin between the tab bar's right side and the last button's right side (default: the same with 'leftMargin')*/
@property (nonatomic, assign) CGFloat                               rightMargin;
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
/**The width of buttons. (default: 100. if 'unifiedWidth' is 'NO', no need to set this property)*/
@property (nonatomic, assign) CGFloat                               buttonWidth;
/**Has bounces effect or not (default: 'NO')*/
@property (nonatomic, assign, getter=isBounces) CGFloat             bounces;
/**Tab bar can be scrolled or not (default: 'YES')*/
@property (nonatomic, assign, getter=isScrollable) CGFloat          scrollable;
/**
 * Click a button in the tab bar according to a 'index'
 */
- (void)clickButtonAtIndex:(NSInteger)index;

@end
