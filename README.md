# DWScrollTabBarController

- A scrollable tabBar with dynamic items. Each item shows a specific view.

You can click [Here](https://github.com/iwufan/DJTabBarController) to get the Swift version of this framework.

# Why shoud I use this framework
- You can build a view controller with scrollable tabBar in only a few steps.<br>
- The items in the tabBar can be dynamic. The items in the tabBar can be different every time you open the view controller. <br>
- You don't have to create a class file for each item. What you should do is to create a view for each item.<br>

- You can use this framework to create view controllers like these below.

- It can be used on iPhoneX now.

![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example1.gif)
![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example2.gif)
![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example3.gif)
![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example4.gif)
![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example5.gif)
![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example6.gif)
![image](https://github.com/iwufan/Resources/blob/master/Images/DWScrollTabBarController/example7.gif)

# Installation
- ### Cocoapods

  In your Podfile
  
  `pod 'DWScrollTabBarController'`
  
- ### Manual import<br>

  Drag all the files in the `DWScrollTabBarController` folder to your project.

# How to use it
- ### Extends DWScrollTabBarController <br>
  ```
  #import "DWScrollTabBarController.h"

  @interface YourViewController : DWScrollTabBarController

  @end
  ```
  NOTE: You can make `DWScrollTabBarController` extends your base ViewController in your project if necessary, instead of extending `UIViewController`.
  
- ### Setup customized properties in `viewDidLoad` method
  ```
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
  ```
  #### Tip: You DO NOT have to setup all these properties. Every property has a default value.
    `unifiedWidth` is a special property. It's default value is 'NO', so if you do not set it as 'YES', the tabBar item's width is calculated based on the item's title. The more words on the title, the wider the title.<br>
  If you set `unifiedWidth` as 'YES', every item's width will be the same. You should set `buttonWidth` as you want, it has a default value 100. 
  #### Note: If you show `indicatorLine` and `bottomLine` at the same time. The indicator line may be covered by bottom line.
- ### Setup data in `viewDidLoad` method
  ```
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
  ```
  #### Tip: You MUST setup data AFTER setting properties. Or you will get nothing in the tabBar.
  The `setupSubViews` method should be implemented by yourself. Please refer to below for details.
- ### LoadDefaultData in `viewDidLoad` method
  ```
  [self loadTableViewData];
  ```
  Load first type's data by default.
  This method should be implemented by yourself. Please refer to demo for details.
- ### Create your own tableView to display data.
  This tableView should have a property `typeID`, and load data in its setter method.
  ```
  - (void)setTypeID:(NSString *)typeID {
    
      _typeID = typeID;

      [self loadData];
  }
  ```
  Then you can load data based on different types.
 
  Add them to the property `tableViewArray`
  ```
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
  ```
  ```
  // Add all tableviews that need to display data
  self.tableViewArray = [self setupSubViews];
  ```
  You can refer to the demo project for the example tableView.
  
- ### Implement `DWScrollTabBarController` delegate methods. 
    Please refer to demo for details. You can use the codes of the two methods in the demo directly.
    ```
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
    ```
  #### Tip: You ONLY can use these two methods above to load every page's data. Please add your 'loadData' method to these two methods.
  - Above is all you shoud do with this framework. More you shoud do are add customized views to this framework and load data from your server. <br>
#### Plese refer to demo for details.
