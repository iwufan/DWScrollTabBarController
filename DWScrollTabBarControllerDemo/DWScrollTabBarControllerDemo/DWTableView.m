//
//  DWTableView.m
//  DWScrollTabBarControllerDemo
//
//  Created by jiadawei on 18/04/2017.
//  Copyright © 2017 david. All rights reserved.
//

#import "DWTableView.h"

@interface DWTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView               *tableView;
@property (nonatomic, strong) NSMutableArray            *dataArray;

@end

@implementation DWTableView

- (void)setTypeID:(NSString *)typeID {
    
    _typeID = typeID;
    
    [self loadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell%ld%ld";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 加载数据

- (void)loadData {
    
    // 清空，防止重复添加数据
    if (self.dataArray.count != 0) {
        [self.dataArray removeAllObjects];
    }
    // 加载数据（从服务器请求数据）
    NSMutableArray *tempArray = [NSMutableArray array];
    
    NSArray *titleArray =  @[@"军事", @"游戏", @"社会", @"体育", @"娱乐", @"头条", @"女性", @"政治", @"时尚"];
    
    for (int i = 0; i < 20; i++) {
        [tempArray addObject:[NSString stringWithFormat:@"%@ - %d", titleArray[self.typeID.intValue], i]];
    }
    // 得到某一类的数据
    self.dataArray = tempArray;
    
    [self.tableView reloadData];
}


#pragma mark - getter
- (UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate     = self;
        _tableView.dataSource   = self;

        _tableView.rowHeight = 50;
        
        [self addSubview:_tableView];
    }
    
    return _tableView;
}

- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    
    return _dataArray;
}

@end
