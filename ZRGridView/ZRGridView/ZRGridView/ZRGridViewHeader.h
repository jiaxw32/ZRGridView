//
//  ZRGridViewHeader.h
//  ZRGridView
//
//  Created by jiaxw-mac on 2017/4/29.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kZRGridViewHeaderReuseIdentifier = @"ZRGridViewHeader";

typedef void(^OnColumnClickHandler)(UIButton *sender,NSInteger index);

@interface ZRGridViewHeader : UICollectionReusableView

@property (nonatomic,strong) UIColor *headerBackgroudColor;

@property (nonatomic,strong) UIColor *fieldTitleColor;

@property (nonatomic,strong) NSArray *fields;

@property (nonatomic,copy) OnColumnClickHandler columnClickHandler;

- (void)setFields:(NSArray *)fields andWidths:(NSArray *)widths;

@end
