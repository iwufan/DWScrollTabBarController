//
//  DWViewController.m
//  DWScrollTabBarDemo
//
//  Created by jiadawei on 16/03/2017.
//  Copyright © 2017 david. All rights reserved.
//

#import "DWViewController.h"

@interface DWViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation DWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"可滚动选项卡";
    // 颜色
    self.normalColor    = [UIColor blackColor];     // 按钮标题字体颜色 - 未选中，默认黑色
    self.currentColor   = [UIColor whiteColor];     // 按钮标题字体颜色 - 选中，默认橙色
    self.normalBgColor  = [UIColor blueColor];      // 按钮背景颜色   - 未选中，默认白色
    self.currentBgColor = [UIColor purpleColor];    // 按钮背景颜色   - 选中，默认白色
    self.tabBarBgColor  = [UIColor orangeColor];    // tabBar的背景颜色，
    self.tabBarHeight   = 30;                       // tabBar的高度，同按钮的高度一样
    // 按钮宽度
    self.unifiedWidth   = YES;                      // 是否所有按钮的宽度都相等，如果此值为YES，需要设置按钮宽度，默认100
    self.buttonWidth    = 70;                       // 按钮宽度，如果未设置unifiedWidth为YES，则设置了也不起作用
    // 指示条
    self.showLine       = YES;                      // 是否显示指示条，默认不显示
    self.lineHeight     = 2;                        // 指示条高度，默认1
    self.lineColor      = [UIColor blueColor];      // 指示条颜色，默认跟选中时的标题颜色一样
    self.lineWidth      = 50;                       // 指示条宽度，默认跟按钮宽度相同（如果按钮不是相同宽度的，须谨慎设置）
    self.lineCenter     = YES;                      // 指示条是否居中显示，默认不居中
    // 间距
    self.leftMargin     = 0;                        // tabBar中左边第一个按钮距tabBar左侧的距离，默认0
    self.rightMargin    = 0;                        // tabBar中右边最后一个按钮距tabBar右侧的距离，默认跟leftMargin相同
    self.margin         = 10;                       // 按钮之间的间距，默认0
    // 其他
    self.bounces        = YES;                      // tabBar是否有弹簧效果，默认无
    
    self.typesArray = @[@"军事", @"游戏", @"新闻", @"体育", @"娱乐", @"头条", @"军事", @"游戏", @"新闻"];
    
    self.tableViewArray = [self setupSubViews];
    // 加载数据，默认加载第一个列表的数据
    [self loadDataWithID:0];
}
/**
 * 添加各个列表
 */
- (NSMutableArray *)setupSubViews {

    NSMutableArray *typeTableViews = [NSMutableArray array];
    
    for (int i = 0; i < self.typesArray.count; i++) {
        UITableView *tablView = [[UITableView alloc] init];
        tablView.backgroundColor = [UIColor yellowColor];
       
        tablView.delegate = self;
        tablView.dataSource = self;
        
        [typeTableViews addObject:tablView];
    }
    
    return typeTableViews;
}
/**
 * 设置每个列表的数据
 */
- (void)setDataArray:(NSMutableArray *)dataArray {
    
    _dataArray = dataArray;
    
    UITableView *tableView = self.tableViewArray[self.currentPage];
    [tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"tempCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

   NSLog(@"%@", self.dataArray[indexPath.row]);
}

#pragma mark - 父类代理方法
/**
 * 点击tabBar上的按钮
 */
- (void)tabBar:(DWScrollTabBar *)tabBar didClickTabButton:(UIButton *)tabBarButton {
    [super tabBar:tabBar didClickTabButton:tabBarButton];
   
    [self loadDataWithID:tabBarButton.tag];
}
/**
 * 滚动列表切换页面时
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [super scrollViewDidEndDecelerating:scrollView];
    
    [self loadDataWithID:self.currentPage];
}

#pragma mark - 加载数据
- (void)loadDataWithID:(NSInteger)typeID {

    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (int i = 0; i < 20; i++) {
        NSString *title = self.typesArray[typeID];
        [tempArray addObject:[NSString stringWithFormat:@"%@ - %d", title, i]];
    }
    
    self.dataArray = tempArray;
}

@end
