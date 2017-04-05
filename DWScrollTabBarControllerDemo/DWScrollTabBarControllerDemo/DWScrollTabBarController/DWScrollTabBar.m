//
//  DWScrollTabBar.m
//  DWScrollTabBarDemo
//
//  Created by jiadawei on 16/03/2017.
//  Copyright © 2017 david. All rights reserved.
//

#import "DWScrollTabBar.h"


#define kScreenWidth self.frame.size.width

@interface DWScrollTabBar ()

/**当前选中的按钮*/
@property (nonatomic, strong) UIButton              *selectedButton;
/**存放每个按钮对应的指示条*/
@property (nonatomic, strong) NSMutableDictionary   *lineDict;
@end

@implementation DWScrollTabBar

- (void)setTabItemArray:(NSArray *)tabItemArray{
    
    _tabItemArray = tabItemArray;
    
    [self addTabButtonsWithTabItemArray:tabItemArray];
}

- (void)addTabButtonsWithTabItemArray:(NSArray *)tabItemArray{
    
    if (tabItemArray.count == 0) {
        return;
    }
    
    CGFloat leftOffset = 0;
    CGFloat buttonWidths = 0;
    
    for (int i = 0; i < tabItemArray.count; i++) {
        
        UIButton *tabButton = [[UIButton alloc] init];

        [tabButton setTitle:tabItemArray[i] forState:UIControlStateNormal];
        [tabButton setTitleColor:self.normalColor forState:UIControlStateNormal];
        [tabButton setTitleColor:self.currentColor forState:UIControlStateSelected];
        tabButton.backgroundColor = self.normalBgColor;
        
        tabButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        tabButton.tag = i;      // 用于区分点击的是哪个
        
        [tabButton addTarget:self action:@selector(clickTabButtonOnTabBar:) forControlEvents:UIControlEventTouchUpInside];
        
        NSDictionary *textAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
        
        // 按钮宽度
        CGFloat buttonWidth = 0;
        
        if (!self.isUnifiedWidth) {
            // 如果不使用统一宽度，则使用按钮标题宽度
            buttonWidth = [tabItemArray[i] boundingRectWithSize:CGSizeMake(kScreenWidth - 2 * self.leftMargin, 14) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttrs context:nil].size.width;
        } else {
            // 如果未设置按钮宽度，默认100
            buttonWidth = self.buttonWidth;
        }
        
        buttonWidths += buttonWidth;    // 所有按钮的宽度
        
        leftOffset = self.leftMargin + buttonWidths + self.margin * i - buttonWidth;
        
        tabButton.frame = CGRectMake(leftOffset, 0, buttonWidth, self.tabBarHeight);
        
        [self.scrollView addSubview:tabButton];
        // 显示时，添加线
        if (self.isShowLine) {
            // 添加指示线
            CGFloat lineWidth = self.lineWidth <= 0 ? buttonWidth : self.lineWidth;
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = self.lineColor;
            line.hidden = YES;
            
            CGFloat lineX = self.isLineCenter ? (buttonWidth - lineWidth) / 2 : 0;
            
            line.frame = CGRectMake(lineX, self.tabBarHeight - self.lineHeight, lineWidth, self.lineHeight);
            
            [tabButton addSubview:line];
            
            [self.lineDict setObject:line forKey:[NSString stringWithFormat:@"%d", i]];
        }
        
        // 计算左侧距离
        leftOffset += buttonWidth;
        
        // 默认选中第1个按钮
        if (i == 0) {
            [self clickTabButtonOnTabBar:tabButton];
        }
    }
    // 设置scrollView的内容大小
    CGFloat rightMargin = self.rightMargin > 0 ? self.rightMargin : self.leftMargin;
    self.scrollView.contentSize = CGSizeMake(leftOffset + rightMargin, 0);
}

- (void)clickTabButtonOnTabBar:(UIButton *)button{
    // 点击按钮时，先把这个值设置为NO，因为不是通过滚动列表来自动点击tab按钮
    self.fromScrollTable = NO;
    // 调用点击按钮的方法
    [self clickTabButton:button];
}

- (void)clickTabButton:(UIButton *)button{
    
    if (self.selectedButton == button) {
        return;
    }
    // 改变按钮样式
    self.selectedButton.selected = NO;
    self.selectedButton.backgroundColor = self.normalBgColor;
    UIView *selectedLine = self.lineDict[[NSString stringWithFormat:@"%ld", self.selectedButton.tag]];
    selectedLine.hidden = YES;
    
    button.selected = YES;
    button.backgroundColor = self.currentBgColor;
    UIView *currentLine = self.lineDict[[NSString stringWithFormat:@"%ld", button.tag]];
    currentLine.hidden = NO;
    
    self.selectedButton = button;
    // 滚动tabBar
    [self scrollTabBarWithButton:button];
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickTabButton:)]) {
        [self.delegate tabBar:self didClickTabButton:button];
    }
}
/**
 * 滚动tabBar
 */
- (void)scrollTabBarWithButton:(UIButton *)button{
    
    CGFloat maxWidth = button.frame.origin.x + button.frame.size.width;
    
    if (maxWidth > kScreenWidth){
        
        CGFloat offsetX = maxWidth - kScreenWidth;
        if (button.tag < self.tabItemArray.count - 1){
            offsetX = offsetX + 60.0f;
        }
        
        if (button.tag == self.tabItemArray.count - 1) {
            offsetX = self.scrollView.contentSize.width - kScreenWidth;
        }
        
        [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

#pragma mark - getter
- (UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.bounces = self.isBounces;
        
        [self addSubview:_scrollView];
    }
    
    return _scrollView;
}

- (NSMutableDictionary *)lineDict{
    
    if (_lineDict == nil) {
        _lineDict = [[NSMutableDictionary alloc] init];
    }
    
    return _lineDict;
}


@end
