# ZRGridView
ZRGridView是一个类似Excel表格的组件，用于展示多行多列的表格数据

![](https://github.com/jiaxw32/ZRGridView/blob/master/ZRGridView/ZRGridView/gridview.gif)

# 特性
  * 支持水平、垂直方向滚动
  * 表格表头悬浮
  * 自定义表头、行高度及每列宽度
  * 单元格颜色可以自定义，格网显示控制

# 使用

  ```
  ZRGridViewLayoutAndStyle *gridViewLayout = [[ZRGridViewLayoutAndStyle alloc] init];
  gridViewLayout.showGridLine = YES;
  gridViewLayout.headerBackgroudColor = UIColorFromRGB(0x26b8f2);
  gridViewLayout.fieldTitleColor = [UIColor whiteColor];

  CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
  ZRGridView *gridView = [[ZRGridView alloc] initWithFrame:CGRectMake(16, 200, screenWidth - 16 * 2, screenWidth*2/3.0f) gridViewLayoutAndStyle:gridViewLayout];
  gridView.gridViewDelegate = self;
  gridView.gridViewDataSource = self;
  [self.view addSubview:gridView]; 
  ```

