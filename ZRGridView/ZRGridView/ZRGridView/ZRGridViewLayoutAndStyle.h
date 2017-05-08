//
//  ZRGridViewLayout.h
//  ZRGridView
//
//  Created by jiaxw-mac on 2017/4/14.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRGridViewLayoutAndStyle : UICollectionViewFlowLayout

@property (nonatomic,assign) CGFloat headerHeight;

@property (nonatomic,assign) CGFloat rowHeight;

@property (nonatomic,assign) CGFloat columnWidth;

@property (nonatomic,strong) UIColor *rowBackgroudColor;

@property (nonatomic,strong) UIColor *headerBackgroudColor;

@property (nonatomic,strong) UIColor *fieldTitleColor;

@property (nonatomic,assign) BOOL showGridLine;

@end
