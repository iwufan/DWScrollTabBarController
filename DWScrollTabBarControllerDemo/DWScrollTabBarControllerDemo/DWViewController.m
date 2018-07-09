//
//  DWViewController.m
//  DWScrollTabBarDemo
//
//  Created by jiadawei on 16/03/2017.
//  Copyright © 2017 david. All rights reserved.
//

#import "DWViewController.h"
#import "DWTableView.h"

@interface DWViewController ()

@end

@implementation DWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.navigationItem.title = @"可滚动选项卡控制器";
    
    // set properties for tab bar
    [self setupTabbarProperties];
    
    /**
     !!!!! NOTE:
      You MUST set properties of tab bar before set value for 'typesArray', otherwise the properties
      you set for tab bar will not take effect.
      You can hardcode the types in the code or get the types data from server. It doesn't matter how
      many types are.
     */
    self.typesArray = @[@"军事", @"游戏", @"社会", @"体育", @"娱乐", @"头条", @"女性", @"政治", @"时尚"];
    
    // Add all tableviews that need to display data
    self.tableViewArray = [self setupSubViews];
    // load data for tableviews, load data for the first tableview by default
    [self loadTableViewData];
}

- (void)setupTabbarProperties {
    // color
    self.normalTitleColor       = [UIColor blackColor];
    self.currentTitleColor      = [UIColor whiteColor];
    self.normalButtonBgColor    = [UIColor blueColor];
    self.currentButtonBgColor   = [UIColor orangeColor];
    self.tabBarBgColor          = [UIColor whiteColor];
    // font
    self.normalTitleFont        = [UIFont systemFontOfSize:13];
    self.currentTitleFont       = [UIFont systemFontOfSize:18];
    // height
    self.tabBarHeight           = 30;
    // button width
    self.unifiedWidth           = YES;
    self.buttonWidth            = 70;
    // indicator line
    self.showIndicatorLine      = YES;
    self.indicatorLineHeight    = 2;
    self.indicatorLineColor     = [UIColor redColor];
    self.indicatorLineWidth     = 50;
    self.indicatorLineCenter    = YES;
    // bottom line
    self.showBottomLine         = YES;
    self.bottomLineHeight       = 1;
    self.bottomLineColor        = [UIColor blackColor];
    // margin
    self.showViewMargin         = YES;
    self.viewMargin             = 10;
    self.leftMargin             = 10;
    self.rightMargin            = 0;
    self.buttonMargin           = 10;
    // others
    self.bounces                = YES;
    self.scrollable             = YES;
}

/**
 * Add all tableviews that need to display data
 */
- (NSMutableArray *)setupSubViews {
    
    NSMutableArray *typeTableViews = [NSMutableArray array];
    
    for (int i = 0; i < self.typesArray.count; i++) {
        
        DWTableView *tableView = [[DWTableView alloc] init];
        
        [typeTableViews addObject:tableView];
    }
    
    return typeTableViews;
}

#pragma mark - protocol method of parent class
/**
 * click buttons in the tab bar
 */
- (BOOL)tabBar:(DWScrollTabBar *)tabBar didClickTabButton:(UIButton *)tabBarButton {
    
    // if the click is caused by scroll the tableviews, then don't need to load data
    BOOL isScrolled = [super tabBar:tabBar didClickTabButton:tabBarButton];
    
    if (!isScrolled) {
        // load data for a specific type
        [self loadTableViewData];
    }
    
    return NO;
}
/**
 * Change page when scroll tableviews
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [super scrollViewDidEndDecelerating:scrollView];
    // load data for a specific type
    [self loadTableViewData];
}
/**
 * load data according to types
 */
- (void)loadTableViewData{
    
    DWTableView *allView = self.tableViewArray[self.currentPage];
    allView.typeID = [NSString stringWithFormat:@"%ld", self.currentPage];
}

@end
