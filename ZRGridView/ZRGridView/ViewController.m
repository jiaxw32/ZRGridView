//
//  ViewController.m
//  ZRGridView
//
//  Created by jiaxw-mac on 2017/5/8.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

#import "ViewController.h"
#import "ViewController.h"
#import "ZRGridView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()<ZRGridViewDelegate,ZRGridViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    ZRGridViewLayoutAndStyle *gridViewLayout = [[ZRGridViewLayoutAndStyle alloc] init];
    gridViewLayout.showGridLine = YES;
    gridViewLayout.headerBackgroudColor = UIColorFromRGB(0x26b8f2);
    gridViewLayout.fieldTitleColor = [UIColor whiteColor];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    ZRGridView *gridView = [[ZRGridView alloc] initWithFrame:CGRectMake(16, 200, screenWidth - 16 * 2, screenWidth*2/3.0f) gridViewLayoutAndStyle:gridViewLayout];
    gridView.gridViewDelegate = self;
    gridView.gridViewDataSource = self;
    [self.view addSubview:gridView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ZRGridViewDataSource

- (NSInteger)numberOfColumnsInGridView:(ZRGridView *)gridView{
    return 10;
}

- (NSInteger)numberOfRowsInGridView:(ZRGridView *)gridView{
    return 100;
}

- (NSString *)gridView:(ZRGridView *)gridView titleOfColumnsAtIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"field_%lu",index];
}

- (NSString *)gridView:(ZRGridView *)gridView valueAtRow:(NSInteger)rowIndex column:(NSInteger)columnIndex{
    return [NSString stringWithFormat:@"%lu*%lu",rowIndex,columnIndex];
}

- (UIColor *)gridView:(ZRGridView *)gridView itemBackgroudColorAtRow:(NSInteger)rowIndex column:(NSInteger)column{
    if (rowIndex%2) {
        return UIColorFromRGB(0xEEEEEE);
    } else {
        return [UIColor whiteColor];
    }
}

- (CGFloat)gridView:(ZRGridView *)gridView widthForColumn:(NSInteger)index{
    if (index%2) {
        return 100;
    } else {
        return 80;
    }
}


@end
