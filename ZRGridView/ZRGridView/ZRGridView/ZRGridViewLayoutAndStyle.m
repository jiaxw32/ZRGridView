//
//  ZRGridViewLayout.m
//  ZRGridView
//
//  Created by jiaxw-mac on 2017/4/14.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

#import "ZRGridViewLayoutAndStyle.h"

@implementation ZRGridViewLayoutAndStyle

- (instancetype)init{
    if (self = [super init]) {
        self.sectionHeadersPinToVisibleBounds = YES;
        [self initialData];
    }
    return self;
}

- (void)initialData{
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sectionInset = UIEdgeInsetsZero;
    
    self.rowHeight = 40;
    self.columnWidth = 100;
    self.headerHeight = 60;
    self.rowBackgroudColor = [UIColor whiteColor];
    self.headerBackgroudColor = [UIColor whiteColor];
    self.fieldTitleColor = [UIColor blackColor];
    self.showGridLine = YES;
}

@end
