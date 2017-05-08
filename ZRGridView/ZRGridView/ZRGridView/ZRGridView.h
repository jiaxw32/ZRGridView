//
//  ZRGridView.h
//  ZRGridView
//
//  Created by jiaxw-mac on 2017/4/14.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRGridViewLayoutAndStyle.h"

@class ZRGridView;

@protocol ZRGridViewDelegate <NSObject>

@optional

- (CGFloat)gridView:(ZRGridView *)gridView widthForColumn:(NSInteger)index;

- (CGFloat)gridView:(ZRGridView *)gridView heightForRow:(NSInteger)index;

- (CGFloat)headerHeightOfGridView:(ZRGridView *)gridView;

- (UIColor *)gridView:(ZRGridView *)gridView itemBackgroudColorAtRow:(NSInteger)rowIndex column:(NSInteger)column;

- (void)gridView:(ZRGridView *)gridView didSelectRowAtIndex:(NSInteger)index;

- (void)gridView:(ZRGridView *)gridView didSelectColumnAtIndex:(NSInteger)index;

- (void)gridView:(ZRGridView *)gridView didSelectItemAtRow:(NSInteger)rowIndex column:(NSInteger)columnIndex;

@end

@protocol ZRGridViewDataSource <NSObject>

@required

- (NSInteger)numberOfColumnsInGridView:(ZRGridView *)gridView;

- (NSString *)gridView:(ZRGridView *)gridView titleOfColumnsAtIndex:(NSInteger)index;

- (NSInteger)numberOfRowsInGridView:(ZRGridView *)gridView;

- (NSString *)gridView:(ZRGridView *)gridView valueAtRow:(NSInteger)rowIndex column:(NSInteger)columnIndex;

@end

@interface ZRGridView : UIScrollView

- (instancetype)initWithGridViewLayoutAndStyle:(ZRGridViewLayoutAndStyle *)gridViewLayoutAndStyle;

- (instancetype)initWithFrame:(CGRect)frame gridViewLayoutAndStyle:(ZRGridViewLayoutAndStyle *)gridViewLayoutAndStyle;

@property (nonatomic,strong) ZRGridViewLayoutAndStyle *gridViewLayoutAndStyle;

@property (nonatomic,weak) id<ZRGridViewDelegate> gridViewDelegate;

@property (nonatomic,weak) id<ZRGridViewDataSource> gridViewDataSource;

- (void)reloadData;

@end
