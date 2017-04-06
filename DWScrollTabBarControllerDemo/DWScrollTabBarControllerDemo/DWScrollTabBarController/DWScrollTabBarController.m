//
//  DWScrollTabBarController.m
//  DWScrollTabBarControllerDemo
//
//  Created by jiadawei on 06/04/2017.
//  Copyright © 2017 david. All rights reserved.
//

#import "DWScrollTabBarController.h"
#import "DWScrollTabBar.h"

#define DW_SCREEN_WIDTH self.view.frame.size.width
#define DW_SCREEN_HEIGHT self.view.frame.size.height

@interface DWScrollTabBarController ()

/**上一次打开的列表*/
@property (nonatomic, assign) NSInteger previousPage;

@end

@implementation DWScrollTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ！！！！ 这句话不加看不到tabBar上的内容
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setTypesArray:(NSArray *)typesArray {
    
    _typesArray = typesArray;
    
    // 添加tabbar
    [self addScrollTabBar];
    // 设置各种颜色
    [self setupColors];
    // 设置按钮宽度
    [self setupButtonWidth];
    // 设置间距
    [self setupMargins];
    // 设置默认值
    [self setupDefaults];
    // 设置指示条
    [self setupLine];
    // 设置字体
    [self setupFonts];
    // 设置内容
    self.scrollTabBar.tabItemArray = typesArray;
}

#pragma mark - 添加子控件
- (void)addScrollTabBar {
    
    // 可滚动tabBar
    CGFloat tabBarHeight = self.tabBarHeight <= 0 ? 40 : self.tabBarHeight;
    
    DWScrollTabBar *scrollTabBar = [[DWScrollTabBar alloc] initWithFrame:CGRectMake(0, 64, DW_SCREEN_WIDTH, tabBarHeight)];
    scrollTabBar.delegate = self;
    
    [self.view addSubview:scrollTabBar];
    
    self.scrollTabBar = scrollTabBar;
}
/**
 * 将需要展示的列表都加入到scrollView中
 */
- (void)setTableViewArray:(NSMutableArray *)tableViewArray{
    
    _tableViewArray = tableViewArray;
    
    [self addTableViews];
}

- (void)addTableViews {
    
    CGFloat tabBarHeight = self.tabBarHeight <= 0 ? 40 : self.tabBarHeight;
    
    for (int i = 0; i < self.typesArray.count; i++) {
        // 列表
        UIView *view = self.tableViewArray[i];
        
        CGFloat leftOffset = i * DW_SCREEN_WIDTH;
        
        view.frame = CGRectMake(leftOffset, 0, DW_SCREEN_WIDTH, DW_SCREEN_HEIGHT - 64  - tabBarHeight);
        
        [self.scrollView addSubview:view];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.tableViewArray.count * DW_SCREEN_WIDTH, 0);
}

- (void)setupColors {
    
    self.scrollTabBar.normalColor       = self.normalColor == nil ? [UIColor blackColor] : self.normalColor;
    self.scrollTabBar.currentColor      = self.currentColor == nil ? [UIColor orangeColor] : self.currentColor ;
    self.scrollTabBar.normalBgColor     = self.normalBgColor == nil ? [UIColor whiteColor] : self.normalBgColor;
    self.scrollTabBar.currentBgColor    = self.currentBgColor == nil ? [UIColor whiteColor] : self.currentBgColor;
    self.scrollTabBar.backgroundColor   = self.tabBarBgColor == nil ? [UIColor whiteColor] : self.tabBarBgColor;
    self.scrollTabBar.lineColor         = self.lineColor == nil ? self.scrollTabBar.currentColor : self.lineColor;
}

- (void)setupButtonWidth {
    
    self.scrollTabBar.unifiedWidth  = self.isUnifiedWidth;
    self.scrollTabBar.buttonWidth   = self.buttonWidth <= 0 && self.isUnifiedWidth ? 100 : self.buttonWidth;
}

- (void)setupMargins {
    
    self.scrollTabBar.margin        = self.margin;
    self.scrollTabBar.leftMargin    = self.leftMargin;
    self.scrollTabBar.rightMargin   = self.rightMargin;
}

- (void)setupDefaults {
    
    self.scrollTabBar.bounces       = self.isBounces;
    self.scrollTabBar.tabBarHeight  =  self.tabBarHeight <= 0 ? 40 : self.tabBarHeight;
}

- (void)setupLine {
    
    self.scrollTabBar.lineHeight    = self.lineHeight <= 0 ? 1 : self.lineHeight;
    self.scrollTabBar.lineWidth     = self.lineWidth;
    self.scrollTabBar.lineCenter    = self.isLineCenter;
    self.scrollTabBar.showLine      = self.isShowLine;
}

- (void)setupFonts {
    
    self.scrollTabBar.normalFont = self.normalFont == nil ? [UIFont systemFontOfSize:14] : self.normalFont;
    self.scrollTabBar.currentFont = self.currentFont == nil ? self.scrollTabBar.normalFont : self.currentFont;
}

#pragma mark - DWScrollTabBarDelegate
- (void)tabBar:(DWScrollTabBar *)tabBar didClickTabButton:(UIButton *)tabBarButton{
    
    // 如果是滚动列表引起的选中，则直接返回，不需要再去重复滚动列表
    if (tabBar.isFromScrollTable) {
        
        return;
    }
    // 根据选中的tabBar按钮，滚动到相应的列表
    [self.scrollView setContentOffset:CGPointMake(tabBarButton.tag * DW_SCREEN_WIDTH, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 当前页数
    self.currentPage = scrollView.contentOffset.x / DW_SCREEN_WIDTH;
    // 如果是同一页，则直接返回
    if (self.previousPage == self.currentPage) {
        return;
    }
    
    // 选择相应的tab
    // 当前tab按钮
    UIButton *currentTabButton = self.scrollTabBar.scrollView.subviews[self.currentPage];
    // 滚动列表引起的选中
    self.scrollTabBar.fromScrollTable = YES;
    // 选中当前tab按钮
    [self.scrollTabBar clickTabButton:currentTabButton];
    
    // 存储页数
    self.previousPage = self.currentPage;
}

#pragma mark - getter
- (UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        
        CGFloat tabBarHeight = self.tabBarHeight <= 0 ? 40 : self.tabBarHeight;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  64 + tabBarHeight, DW_SCREEN_WIDTH, DW_SCREEN_HEIGHT - tabBarHeight)];
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
