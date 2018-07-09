//
//  DWScrollTabBarController.m
//  DWScrollTabBarControllerDemo
//
//  Created by jiadawei on 06/04/2017.
//  Copyright © 2017 david. All rights reserved.
//

#import "DWScrollTabBarController.h"
#import "DWScrollTabBar.h"

#define kScreenWidth    self.view.frame.size.width
#define kScreenHeight   self.view.frame.size.height
#define KIsIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@interface DWScrollTabBarController ()

@property (nonatomic, assign) NSInteger navHeight;
/**The index of last page that opened.*/
@property (nonatomic, assign) NSInteger previousPage;

@end

@implementation DWScrollTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ！！！！ You won't see the content in the tab bar if you don't add the code below.
    self.automaticallyAdjustsScrollViewInsets = NO;
    // The tab bar is scrollable by default.
    self.scrollable = YES;

    [self setNavHeight];
}

- (void)setTypesArray:(NSArray *)typesArray {
    
    _typesArray = typesArray;
    
    // add tab bar
    [self addScrollTabBar];
    // set all colors
    [self setupColors];
    // set width of buttons
    [self setupButtonWidth];
    // set margins
    [self setupMargins];
    // set all default values
    [self setupDefaults];
    // set all lines
    [self setupLine];
    // set all fonts
    [self setupFonts];
    // set contents of tab bar
    self.scrollTabBar.tabItemArray = typesArray;
}

- (void)setNavHeight {
    
    self.navHeight = 64;
    
    if (KIsIPhoneX) {
        self.navHeight += 24;
    }
}

#pragma mark - add sub views
- (void)addScrollTabBar {
    
    // a scrollable tab bar
    CGFloat tabBarHeight = self.tabBarHeight <= 0 ? 40 : self.tabBarHeight;
    
    DWScrollTabBar *scrollTabBar = [[DWScrollTabBar alloc] initWithFrame:CGRectMake(0, self.navHeight, kScreenWidth, tabBarHeight)];
    scrollTabBar.delegate = self;
    
    [self.view addSubview:scrollTabBar];
    
    self.scrollTabBar = scrollTabBar;
}
/**
 * Add all sub tableviews into the scrollview
 */
- (void)setTableViewArray:(NSMutableArray *)tableViewArray{
    
    _tableViewArray = tableViewArray;
    
    [self addTableViews];
}

- (void)addTableViews {
    
//    CGFloat tabBarHeight = self.tabBarHeight <= 0 ? 40 : self.tabBarHeight;
    
    for (int i = 0; i < self.typesArray.count; i++) {
        // each sub tableView
        UIView *view = self.tableViewArray[i];
        
        CGFloat leftOffset = i * kScreenWidth;
        view.frame = CGRectMake(leftOffset, 0, kScreenWidth, self.scrollView.frame.size.height);
        
        [self.scrollView addSubview:view];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.tableViewArray.count * kScreenWidth, 0);
}

- (void)setupColors {
    
    self.scrollTabBar.normalTitleColor          = self.normalTitleColor        == nil ? [UIColor blackColor]   : self.normalTitleColor;
    self.scrollTabBar.currentTitleColor         = self.currentTitleColor       == nil ? [UIColor orangeColor]  : self.currentTitleColor ;
    self.scrollTabBar.normalButtonBgColor       = self.normalButtonBgColor     == nil ? [UIColor whiteColor]   : self.normalButtonBgColor;
    self.scrollTabBar.currentButtonBgColor      = self.currentButtonBgColor    == nil ? [UIColor whiteColor]   : self.currentButtonBgColor;
    self.scrollTabBar.backgroundColor           = self.tabBarBgColor           == nil ? [UIColor whiteColor]   : self.tabBarBgColor;
    self.scrollTabBar.indicatorLineColor        = self.indicatorLineColor      == nil ? self.scrollTabBar.currentTitleColor : self.indicatorLineColor;
    self.scrollTabBar.bottomLineColor           = self.bottomLineColor         == nil ? [UIColor lightGrayColor] : self.bottomLineColor;
}

- (void)setupButtonWidth {
    
    self.scrollTabBar.unifiedWidth  = self.isUnifiedWidth;
    self.scrollTabBar.buttonWidth   = self.buttonWidth <= 0 && self.isUnifiedWidth ? 100 : self.buttonWidth;
}

- (void)setupMargins {
    
    self.scrollTabBar.buttonMargin  = self.buttonMargin;
    self.scrollTabBar.leftMargin    = self.leftMargin;
    self.scrollTabBar.rightMargin   = self.rightMargin;
}

- (void)setupDefaults {
    
    self.scrollTabBar.bounces                   = self.isBounces;
    self.scrollTabBar.scrollView.scrollEnabled  = self.isScrollable;
    self.scrollTabBar.tabBarHeight              =  self.tabBarHeight <= 0 ? 40 : self.tabBarHeight;
}

- (void)setupLine {
    // indicator line
    self.scrollTabBar.indicatorLineHeight   = self.indicatorLineHeight <= 0 ? 1 : self.indicatorLineHeight;
    self.scrollTabBar.indicatorLineWidth    = self.indicatorLineWidth;
    self.scrollTabBar.indicatorLineCenter   = self.isIndicatorLineCenter;
    self.scrollTabBar.showIndicatorLine     = self.isShowIndicatorLine;
    // bottom line of tab bar
    self.scrollTabBar.bottomLineHeight      = self.bottomLineHeight <= 0 ? 1 : self.bottomLineHeight;
    self.scrollTabBar.showBottomLine        = self.isShowBottomLine;
}

- (void)setupFonts {
    
    self.scrollTabBar.normalTitleFont   = self.normalTitleFont  == nil ? [UIFont systemFontOfSize:14] : self.normalTitleFont;
    self.scrollTabBar.currentTitleFont  = self.currentTitleFont == nil ? self.scrollTabBar.normalTitleFont : self.currentTitleFont;
}

#pragma mark - DWScrollTabBarDelegate
- (BOOL)tabBar:(DWScrollTabBar *)tabBar didClickTabButton:(UIButton *)tabBarButton{
    
    // If this method is invoked when you scroll the main scrollView, just return 'YES'.
    // Otherwise, the main scrollView will be scrolled again.
    if (tabBar.isFromScrollTable) {
        
        return YES;
    }
    // Scroll to a sub tableView according to the button selected in the tab bar.
    [self.scrollView setContentOffset:CGPointMake(tabBarButton.tag * kScreenWidth, 0) animated:YES];
    // Set index of the current page.
    self.currentPage = tabBarButton.tag;
    
    return NO;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // The index of current page
    self.currentPage = scrollView.contentOffset.x / kScreenWidth;
    // If 'currentPage' is equal to 'previousPage', just return.
    if (self.previousPage == self.currentPage) {
        return;
    }
    
    // Select the tab button accordingly.
    // Get current tab button.
    UIButton *currentTabButton = self.scrollTabBar.scrollView.subviews[self.currentPage];
    // Set 'fromScrollTable' to 'YES'.
    self.scrollTabBar.fromScrollTable = YES;
    // Select current tab button.
    [self.scrollTabBar clickTabButton:currentTabButton];
    
    // Store 'currentPage' to 'previousPage'
    self.previousPage = self.currentPage;
}

#pragma mark - private methods
- (void)clickButtonAtIndex:(NSInteger)index {
    
    [self.scrollTabBar clickButtonAtIndex:index];
}

#pragma mark - getter
- (UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        
        CGFloat tabBarHeight    = self.tabBarHeight <= 0 ? 40 : self.tabBarHeight;
        CGFloat viewMargin = 0;
        
        if (self.showViewMargin) {
            
            viewMargin = self.viewMargin <= 0 ? 10 : self.viewMargin;
        }
        CGFloat height = kScreenHeight - tabBarHeight - viewMargin - self.navHeight;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  self.navHeight + tabBarHeight + viewMargin, kScreenWidth, height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator   = NO;
        
        [self.view addSubview:_scrollView];
    }
    
    return _scrollView;
}

@end
