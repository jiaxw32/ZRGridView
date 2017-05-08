//
//  ZRGridViewCell.h
//  ZRGridView
//
//  Created by jiaxw-mac on 2017/4/14.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString *const kZRGridViewCellReuseIdentifier = @"ZRGridViewCellReuseIdentifier";

@interface ZRGridViewCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *lblValue;

@property (nonatomic,copy) NSString *value;

- (void)setLineVisible:(BOOL)visible rowIndex:(NSInteger)rowIndex colIndex:(NSInteger)colIndex;

@end
