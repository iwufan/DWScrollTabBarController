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
    
    // 颜色
    self.normalColor    = [UIColor blackColor];         // 按钮标题字体颜色 - 未选中，默认黑色
    self.currentColor   = [UIColor whiteColor];         // 按钮标题字体颜色 - 选中，默认橙色
    self.normalBgColor  = [UIColor blueColor];          // 按钮背景颜色   - 未选中，默认白色
    self.currentBgColor = [UIColor orangeColor];        // 按钮背景颜色   - 选中，默认白色
    self.tabBarBgColor  = [UIColor whiteColor];         // tabBar的背景颜色(默认白色)
    // 字体
    self.normalFont     = [UIFont systemFontOfSize:13]; // 按钮标题字体 - 未选中，默认14，非加粗
    self.currentFont    = [UIFont systemFontOfSize:18]; // 按钮标题字体 - 选中，默认同未选中字体一样
    // 高度
    self.tabBarHeight   = 30;                           // tabBar高度（同按钮的高度一样，默认40）
    // 按钮宽度
    self.unifiedWidth   = YES;                          // 是否所有按钮的宽度都相等，如果此值为YES，需要设置按钮宽度，默认100
    self.buttonWidth    = 70;                           // 按钮宽度，如果未设置unifiedWidth为YES，则设置了也不起作用
    // 指示条
    self.showIndicatorLine   = YES;                     // 是否显示指示条，默认不显示
    self.indicatorLineHeight = 2;                       // 指示条高度，默认1
    self.indicatorLineColor  = [UIColor redColor];      // 指示条颜色，默认跟选中时的标题颜色一样
    self.indicatorLineWidth  = 50;                      // 指示条宽度，默认跟按钮宽度相同（如果按钮不是相同宽度的，须谨慎设置）
    self.indicatorLineCenter = YES;                     // 指示条是否居中显示，默认不居中
    // 分割线
    self.showBottomLine       = YES;                    // 是否显示tabBar底部分割线，默认不显示
    self.bottomLineHeight     = 1;                      // 分割线高度，默认1
    self.bottomLineColor      = [UIColor blackColor];   // 分割线颜色，默认lightGrayColor
    // 间距
    self.showViewMargin = YES;                          // 是否在tabBar和下方view中间显示间距
    self.viewMargin     = 10;                           // 间距大小
    self.leftMargin     = 10;                           // tabBar中左边第一个按钮距tabBar左侧的距离，默认0
    self.rightMargin    = 0;                            // tabBar中右边最后一个按钮距tabBar右侧的距离，默认跟leftMargin相同
    self.buttonMargin   = 10;                           // 按钮之间的间距，默认0
    // 其他
    self.bounces        = YES;                          // tabBar是否有弹簧效果，默认无
    // tabbar是否可以滚动
    self.scrollable     = YES;                          // 默认可以滚动
    
    /**
      !!!！! 注意，一定要设置完所有tabBar的所有属性之后再调用这个方法，否则设置的属性将不会起作用
      设置tabBar上的按钮（这些数据可以从前台写死，如果数据是动态的，可以从服务器获取，每次的显示的条目数量无所谓）
     */
    self.typesArray = @[@"军事", @"游戏", @"社会", @"体育", @"娱乐", @"头条", @"女性", @"政治", @"时尚"];
    // 添加所有需要展示的列表
    self.tableViewArray = [self setupSubViews];
    // 加载数据，默认加载第一个列表的数据
    [self loadTableViewData];
}

/**
 * 添加各个列表
 */
- (NSMutableArray *)setupSubViews {
    
    NSMutableArray *typeTableViews = [NSMutableArray array];
    
    for (int i = 0; i < self.typesArray.count; i++) {
        
        DWTableView *tableView = [[DWTableView alloc] init];
        
        [typeTableViews addObject:tableView];
    }
    
    return typeTableViews;
}

#pragma mark - 父类代理方法
/**
 * 点击tabBar上的按钮
 */
- (BOOL)tabBar:(DWScrollTabBar *)tabBar didClickTabButton:(UIButton *)tabBarButton {
    
    // 如果是滚动引起的点击，则不需要加载数据
    BOOL isScrolled = [super tabBar:tabBar didClickTabButton:tabBarButton];
    
    if (!isScrolled) {
        // 加载某一类的数据
        [self loadTableViewData];
    }
    
    return NO;
}
/**
 * 滚动列表切换页面时
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [super scrollViewDidEndDecelerating:scrollView];
    // 加载某一类的数据
    [self loadTableViewData];
}
/**
 * 根据类别加载不同的数据
 */
- (void)loadTableViewData{
    
    DWTableView *allView = self.tableViewArray[self.currentPage];
    allView.typeID = [NSString stringWithFormat:@"%ld", self.currentPage];
}

@end
