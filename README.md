# DWScrollTabBarController

- A scrollable tabBar with dynamic items. Each item shows a specific view.

# Why shoud I use this framework
- You can build a view controller with scrollable tabBar in only a few steps.<br>
- The items in the tabBar can be dynamic. The items in the tabBar can be different every time you open the view controller. <br>
- You don't have to create a class file for each item. What you should do is to create a view for each item.<br>

- You can use this framework to create view controllers like these below.

![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example1.gif)
![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example2.gif)
![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example3.gif)
![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example4.gif)
![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example5.gif)
![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example6.gif)

# How to use it
- ### Manual import<br>

  Drag all the files in the `DWScrollTabBarController` folder to your project.

- ### Extends DWScrollTabBarController <br>
  ```
  #import "DWScrollTabBarController.h"

  @interface YourViewController : DWScrollTabBarController

  @end
  ```
- ### Setup customized properties in `viewDidLoad` method
  ```
  // 颜色
  self.normalColor    = [UIColor blackColor];         // 按钮标题字体颜色 - 未选中，默认黑色
  self.currentColor   = [UIColor whiteColor];         // 按钮标题字体颜色 - 选中，默认橙色
  self.normalBgColor  = [UIColor blueColor];          // 按钮背景颜色   - 未选中，默认白色
  self.currentBgColor = [UIColor purpleColor];        // 按钮背景颜色   - 选中，默认白色
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
  self.showViewMargin   = YES;                        // 是否在tabBar和下方view中间显示间距
  self.viewMargin       = 10;                         // 间距大小
  self.leftMargin     = 10;                           // tabBar中左边第一个按钮距tabBar左侧的距离，默认0
  self.rightMargin    = 0;                            // tabBar中右边最后一个按钮距tabBar右侧的距离，默认跟leftMargin相同
  self.buttonMargin   = 10;                           // 按钮之间的间距，默认0
  // 其他
  self.bounces        = YES;                          // tabBar是否有弹簧效果，默认无
  ```
  #### Tip: You DO NOT have to setup all these properties. Every property has a default value.
    `unifiedWidth` is a special property. It's default value is 'NO', so if you do not set it as 'YES', the tabBar item's width is calculated based on the item's title. The more words on the title, the wider the title.<br>
  If you set `unifiedWidth` as 'YES', every item's width will be the same. You should set `buttonWidth` as you want, it has a default value 100. 
  #### Note: If you show `indicatorLine` and `bottomLine` at the same time. The indicator line may be covered by bottom line.
- ### Setup data in `viewDidLoad` method
  ```
  /**
    !!!！! 注意，一定要设置完所有tabBar的所有属性之后再调用这个方法，否则设置的属性将不会起作用
    设置tabBar上的按钮（这些数据可以从前台写死，如果数据是动态的，可以从服务器获取，每次的显示的条目数量无所谓）
   */
  self.typesArray = @[@"军事", @"游戏", @"社会", @"体育", @"娱乐", @"头条", @"女性", @"政治", @"时尚"];
  // 添加所有需要展示的列表
  self.tableViewArray = [self setupSubViews];
  ```
  #### Tip: You MUST setup data AFTER setting properties. Or you will get nothing in the tabBar.
  The `setupSubViews` method should be implemented by yourself. Please refer to demo for details.
- ### LoadDefaultData in `viewDidLoad` method
  ```
  // 默认加载第一个类别的数据
  [self loadDataWithTypeID:0];
  ```
  Load first type's data by default.<br>
  This method should be implemented by yourself. Please refer to demo for details.
- ### Implement `DWScrollTabBarController` delegate methods. 
  You refer to demo for details. You can use the codes of the two methods in the demo directly.
  ```
  /**
   * 点击tabBar上的按钮
   */
  - (void)tabBar:(DWScrollTabBar *)tabBar didClickTabButton:(UIButton *)tabBarButton {
      // 调用父类方法
      // 加载某一类的数据
  }
  /**
   * 滚动列表切换页面时
   */
  - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
      // 调用父类方法
      // 加载某一类的数据
  }
  ```
  #### Tip: You ONLY can use these two methods above to load every page's data. Please add your 'loadData' method to these two methods.
  - Above is all you shoud do with this framework. More you shoud do are add customized views to this framework and load data from your server. 
  #### NOTE!
  - You should add below codes to your project. Or you will run into a problem when pull up or down the tableview.<br>
    Add a property `pullTableView`<br>
    ```
    /**是否上拉或下拉列表*/
    @property (nonatomic, assign, getter=isPullTableView) BOOL  pullTableView;
    ```
    Implements scrollViewDidScroll method<br>
    ```
    - (void)scrollViewDidScroll:(UIScrollView *)scrollView {
      // 设置是否是上拉或下拉列表
      if (scrollView.contentOffset.y != 0) {
          self.pullTableView = YES;
      }
    }
    ```
    Add a judgement in this method.<br>
    ```
    /**
     * 滚动列表切换页面时
     */
    - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
        // 如果是上拉或下拉列表，直接返回
        if (self.isPullTableView) {
            self.pullTableView = NO;
            return;
        }
        [super scrollViewDidEndDecelerating:scrollView];
        // 加载某一类的数据
        [self loadDataWithTypeID:self.currentPage];
    }
    ```
#### Plese refer to demo for details.
