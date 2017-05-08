//
//  ZRGridView.m
//  ZRGridView
//
//  Created by jiaxw-mac on 2017/4/14.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

#import "ZRGridView.h"
#import "ZRGridViewCell.h"
#import "ZRGridViewHeader.h"

@interface ZRGridView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *fields;

@property (nonatomic,strong) NSArray *fieldsWidth;

@end


@implementation ZRGridView

- (instancetype)initWithGridViewLayoutAndStyle:(ZRGridViewLayoutAndStyle *)gridViewLayoutAndStyle{
    if (self = [super init]) {
        _gridViewLayoutAndStyle = gridViewLayoutAndStyle;
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame gridViewLayoutAndStyle:(ZRGridViewLayoutAndStyle *)gridViewLayoutAndStyle{
    if (self = [super initWithFrame:frame]) {
        _gridViewLayoutAndStyle = gridViewLayoutAndStyle;
        [self setupViews];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupViews];
    }
    return self;
}

- (void)layoutSubviews{
    CGFloat height = self.frame.size.height;
//    height = self.collectionView.contentSize.height;
    __block CGFloat width = 0;
    [self.fieldsWidth enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        width += [obj floatValue];
    }];
    self.collectionView.frame = CGRectMake(0, 0, width, height);
    self.contentSize = self.collectionView.frame.size;
}


- (void)setGridViewLayoutAndStyle:(ZRGridViewLayoutAndStyle *)value{
    _gridViewLayoutAndStyle = value;
    self.collectionView.collectionViewLayout = _gridViewLayoutAndStyle;
}

- (NSArray *)fields{
    NSMutableArray *fields = [NSMutableArray new];
    NSInteger colNum = [self.gridViewDataSource numberOfColumnsInGridView:self];
    for (NSInteger i = 0; i < colNum; i++) {
        NSString *title = [self.gridViewDataSource gridView:self titleOfColumnsAtIndex:i];
        [fields addObject:title ?: @""];
    }
    return fields;
}

- (NSArray *)fieldsWidth{
    NSMutableArray *widths = [NSMutableArray new];
    NSInteger colNum = [self.gridViewDataSource numberOfColumnsInGridView:self];
    for (NSInteger i = 0; i < colNum; i++) {
        if ([self.gridViewDelegate respondsToSelector:@selector(gridView:widthForColumn:)]) {
            CGFloat width = [self.gridViewDelegate gridView:self widthForColumn:i];
            [widths addObject:@(width)];
        } else {
            [widths addObject:@(self.gridViewLayoutAndStyle.columnWidth)];
        }
    }
    return widths;
}

- (void)reloadData{
    [self.collectionView reloadData];
}


- (void)setupViews{
    self.showsVerticalScrollIndicator = YES;
    self.showsHorizontalScrollIndicator = YES;
    self.clipsToBounds = YES;
    
    
    UIView *contentView = self;
    
    if (!self.gridViewLayoutAndStyle) {
        self.gridViewLayoutAndStyle = [[ZRGridViewLayoutAndStyle alloc] init];
    }
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:self.gridViewLayoutAndStyle];
    _collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [contentView addSubview:_collectionView];
    
    [_collectionView registerClass:[ZRGridViewCell class] forCellWithReuseIdentifier:kZRGridViewCellReuseIdentifier];
    [_collectionView registerClass:[ZRGridViewHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kZRGridViewHeaderReuseIdentifier];
}

#pragma mark - UICollectionView delegate and datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger rowNum = 0;
    NSInteger colNum = 0;
    if ([self.gridViewDelegate respondsToSelector:@selector(numberOfColumnsInGridView:)]) {
        colNum = [self.gridViewDataSource numberOfColumnsInGridView:self];
    }
    if ([self.gridViewDataSource respondsToSelector:@selector(numberOfRowsInGridView:)]) {
        rowNum = [self.gridViewDataSource numberOfRowsInGridView:self];
    }
    return rowNum * colNum;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZRGridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kZRGridViewCellReuseIdentifier forIndexPath:indexPath];
    NSInteger colNum = colNum = [self.gridViewDataSource numberOfColumnsInGridView:self];
    NSInteger rowIndex = indexPath.item / colNum;
    NSInteger colIndex = indexPath.item % colNum;
    if (self.gridViewLayoutAndStyle.showGridLine) {
        [cell setLineVisible:YES rowIndex:rowIndex colIndex:colIndex];
    } else {
        [cell setLineVisible:NO rowIndex:rowIndex colIndex:colIndex];
    }
    
    if ([self.gridViewDataSource respondsToSelector:@selector(gridView:valueAtRow:column:)]) {
        NSString *value = [self.gridViewDataSource gridView:self valueAtRow:rowIndex column:colIndex];
        cell.value = value;
    }
    
    if ([self.gridViewDelegate respondsToSelector:@selector(gridView:itemBackgroudColorAtRow:column:)]) {
        UIColor *backgroudColor = [self.gridViewDelegate gridView:self itemBackgroudColorAtRow:rowIndex column:colIndex];
        cell.backgroundColor = backgroudColor;
    } else {
        cell.backgroundColor = self.gridViewLayoutAndStyle.rowBackgroudColor;
    }
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger colNum = colNum = [self.gridViewDataSource numberOfColumnsInGridView:self];
    NSInteger rowIndex = indexPath.item / colNum;
    NSInteger colIndex = indexPath.item % colNum;
    CGFloat width = self.gridViewLayoutAndStyle.columnWidth;
    CGFloat height = self.gridViewLayoutAndStyle.rowHeight;
    if ([self.gridViewDelegate respondsToSelector:@selector(gridView:widthForColumn:)]) {
        width = [self.gridViewDelegate gridView:self widthForColumn:colIndex];
    }
    if ([self.gridViewDelegate respondsToSelector:@selector(gridView:heightForRow:)]) {
        height = [self.gridViewDelegate gridView:self heightForRow:rowIndex];
    }
    return CGSizeMake(width, height);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section == 0) {
        ZRGridViewHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kZRGridViewHeaderReuseIdentifier forIndexPath:indexPath];
        header.headerBackgroudColor = self.gridViewLayoutAndStyle.headerBackgroudColor;
        header.fieldTitleColor = self.gridViewLayoutAndStyle.fieldTitleColor;
        [header setFields:self.fields andWidths:self.fieldsWidth];
        __weak typeof(self) weakSelf = self;
        header.columnClickHandler = ^(UIButton *sender, NSInteger index) {
            if ([weakSelf.gridViewDelegate respondsToSelector:@selector(gridView:didSelectColumnAtIndex:)]) {
                [weakSelf.gridViewDelegate gridView:weakSelf didSelectColumnAtIndex:index];
            }
        };
        return header;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        CGFloat height = self.gridViewLayoutAndStyle.headerHeight;
        if ([self.gridViewDelegate respondsToSelector:@selector(headerHeightOfGridView:)]) {
            height = [self.gridViewDelegate headerHeightOfGridView:self];
        }
        return CGSizeMake(collectionView.frame.size.width, height);
    }
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger colNum = colNum = [self.gridViewDataSource numberOfColumnsInGridView:self];
    NSInteger rowIndex = indexPath.item / colNum;
    NSInteger colIndex = indexPath.item % colNum;
    if ([self.gridViewDelegate respondsToSelector:@selector(gridView:didSelectRowAtIndex:)]) {
        [self.gridViewDelegate gridView:self didSelectRowAtIndex:rowIndex];
    }
    if ([self.gridViewDelegate respondsToSelector:@selector(gridView:didSelectItemAtRow:column:)]) {
        [self.gridViewDelegate gridView:self didSelectItemAtRow:rowIndex column:colIndex];
    }
}


@end
