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

/**The current selected button*/
@property (nonatomic, strong) UIButton              *selectedButton;
/**Store the indicator line of each tabbar button*/
@property (nonatomic, strong) NSMutableDictionary   *lineDict;
/**All tabbar buttons*/
@property (nonatomic, strong) NSMutableArray        *buttonArray;

@end

@implementation DWScrollTabBar

- (void)setTabItemArray:(NSArray *)tabItemArray{
    
    _tabItemArray = tabItemArray;
    [self addTabButtonsWithTabItemArray:tabItemArray];
    [self addBottomLine];
}

- (void)addBottomLine {
    
    if (self.isShowBottomLine) {
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = self.bottomLineColor;
        
        line.frame = CGRectMake(0, self.tabBarHeight - self.bottomLineHeight, self.bounds.size.width, self.bottomLineHeight);
        
        [self addSubview:line];
    }
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
        
        tabButton.titleLabel.font = self.normalFont;
        
        tabButton.tag = i;
        
        [tabButton addTarget:self action:@selector(clickTabButtonOnTabBar:) forControlEvents:UIControlEventTouchUpInside];
        // Calculate the button's size with selected font
        NSDictionary *textAttrs = @{NSFontAttributeName : self.currentFont};
        
        CGFloat buttonWidth = 0;
        
        if (!self.isUnifiedWidth) {
            // If all button's width are not the same, then use the button's title's width as the button's width
            buttonWidth = [tabItemArray[i] boundingRectWithSize:CGSizeMake(kScreenWidth - 2 * self.leftMargin, self.tabBarHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttrs context:nil].size.width;
        } else {
            // If all button's width are the same. Default is 100.
            buttonWidth = self.buttonWidth;
        }
        
        buttonWidths += buttonWidth;    // The sum of all buttons' width
        
        leftOffset = self.leftMargin + buttonWidths + self.buttonMargin * i - buttonWidth;
        
        tabButton.frame = CGRectMake(leftOffset, 0, buttonWidth, self.tabBarHeight);
        
        [self.scrollView addSubview:tabButton];
        
        [self.buttonArray addObject:tabButton];
        
        if (self.isShowIndicatorLine) {
       
            CGFloat lineWidth = self.indicatorLineWidth <= 0 ? buttonWidth : self.indicatorLineWidth;
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = self.indicatorLineColor;
            line.hidden = YES;
            
            CGFloat lineX = self.isIndicatorLineCenter ? (buttonWidth - lineWidth) / 2 : 0;
            
            line.frame = CGRectMake(lineX, self.tabBarHeight - self.indicatorLineHeight, lineWidth, self.indicatorLineHeight);
            
            [tabButton addSubview:line];
            
            [self.lineDict setObject:line forKey:[NSString stringWithFormat:@"%d", i]];
        }
        
        // calculate the sum of left offset
        leftOffset += buttonWidth;
        
        // select the first tabbar button by default
        if (i == 0) {
            [self clickTabButtonOnTabBar:tabButton];
        }
    }
    // set the contentSize of the scrollView
    CGFloat rightMargin = self.rightMargin > 0 ? self.rightMargin : self.leftMargin;
    self.scrollView.contentSize = CGSizeMake(leftOffset + rightMargin, 0);
}

- (void)clickButtonAtIndex:(NSInteger)index {
    
    UIButton *button = self.buttonArray[index];
    
    [self clickTabButtonOnTabBar:button];
}

- (void)clickTabButtonOnTabBar:(UIButton *)button{
    // When click the tabbar button directly, set 'fromScrollTable' to 'NO'.
    self.fromScrollTable = NO;

    [self clickTabButton:button];
}

- (void)clickTabButton:(UIButton *)button{
    
    if (self.selectedButton == button) {
        return;
    }
    // Change the button's style
    self.selectedButton.selected = NO;
    self.selectedButton.backgroundColor = self.normalBgColor;
    UIView *selectedLine = self.lineDict[[NSString stringWithFormat:@"%ld", (long)self.selectedButton.tag]];
    selectedLine.hidden = YES;
    self.selectedButton.titleLabel.font = self.normalFont;
    
    button.selected = YES;
    button.backgroundColor = self.currentBgColor;
    UIView *currentLine = self.lineDict[[NSString stringWithFormat:@"%ld", (long)button.tag]];
    currentLine.hidden = NO;
    button.titleLabel.font = self.currentFont;
    
    self.selectedButton = button;
    // Scroll the tab bar
    [self scrollTabBarWithButton:button];
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickTabButton:)]) {
        [self.delegate tabBar:self didClickTabButton:button];
    }
}
/**
 * Scroll the tab bar.
 */
- (void)scrollTabBarWithButton:(UIButton *)button{
    
    CGFloat maxWidth = button.frame.origin.x + button.frame.size.width;
    
    if (maxWidth > kScreenWidth || kScreenWidth - maxWidth < 30){
        
        CGFloat offsetX = maxWidth - kScreenWidth;
        
        if (button.tag < self.tabItemArray.count - 1){
            
            offsetX += button.frame.size.width + 30;
            
            if (offsetX > self.scrollView.contentSize.width - kScreenWidth) {
                
                offsetX = self.scrollView.contentSize.width - kScreenWidth;
            }
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

- (NSMutableArray *)buttonArray{
    
    if (_buttonArray == nil) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    
    return _buttonArray;
}

@end
