//
//  ZRGridViewCell.m
//  ZRGridView
//
//  Created by jiaxw-mac on 2017/4/14.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

#import "ZRGridViewCell.h"

@interface ZRGridViewCell ()

@property (nonatomic,strong)UIView *leftLine;

@property (nonatomic,strong)UIView *rightLine;

@property (nonatomic,strong)UIView *topLine;

@property (nonatomic,strong)UIView *bottomLine;

@end

@implementation ZRGridViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews{
    self.lblValue = ({
        UILabel *lbl = [UILabel new];
        lbl.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lbl];
        [lbl setTranslatesAutoresizingMaskIntoConstraints:NO];
        lbl;
    });
  
    _topLine = [self createGridLine];
    _leftLine = [self createGridLine];
    _bottomLine = [self createGridLine];
    _rightLine = [self createGridLine];

    [self setupLayout];
}

- (UIView *)createGridLine{
    UIView *v = [UIView new];
    v.hidden = YES;
    v.backgroundColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1];
    [v setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:v];
    return v;
}

- (void)setupLayout{
    NSDictionary *dictMetrics = @{@"hPaddingValue":@6,@"lineSize":@.5f};
    NSDictionary *dictViews = NSDictionaryOfVariableBindings(_lblValue,_topLine,_leftLine,_bottomLine,_rightLine);
    
    NSString *vflValueH = @"|-hPaddingValue-[_lblValue]-hPaddingValue-|";
    NSString *vflValueV = @"V:|[_lblValue]|";
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflValueH options:0 metrics:dictMetrics views:dictViews]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflValueV options:NSLayoutFormatAlignAllCenterY metrics:dictMetrics views:dictViews]];
    
    NSString *vflTopLineH = @"|-0-[_topLine]-0-|";
    NSString *vflTopLineV = @"V:|[_topLine(lineSize)]";
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflTopLineH options:0 metrics:dictMetrics views:dictViews]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflTopLineV options:NSLayoutFormatAlignAllTop metrics:dictMetrics views:dictViews]];
    
    NSString *vflLeftLineH = @"|[_leftLine(lineSize)]";
    NSString *vflLeftLineV = @"V:|-0-[_leftLine]-0-|";
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflLeftLineH options:NSLayoutFormatAlignAllLeft metrics:dictMetrics views:dictViews]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflLeftLineV options:0 metrics:dictMetrics views:dictViews]];
    
    NSString *vfBottomLineH = @"|-0-[_bottomLine]-0-|";
    NSString *vflBottomLineV = @"V:[_bottomLine(lineSize)]|";
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfBottomLineH options:0 metrics:dictMetrics views:dictViews]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflBottomLineV options:NSLayoutFormatAlignAllBottom metrics:dictMetrics views:dictViews]];
    
    NSString *vfRightLineH = @"[_rightLine(lineSize)]|";
    NSString *vflRightLineV = @"V:|-0-[_rightLine]-0-|";
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfRightLineH options:NSLayoutFormatAlignAllRight metrics:dictMetrics views:dictViews]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflRightLineV options:0 metrics:dictMetrics views:dictViews]];
}

- (void)setValue:(NSString *)value{
    _value = value;
    _lblValue.text = _value;
}

- (void)setLineVisible:(BOOL)visible rowIndex:(NSInteger)rowIndex colIndex:(NSInteger)colIndex{
    if (visible) {
        self.bottomLine.hidden = NO;
        self.rightLine.hidden = NO;
        self.topLine.hidden = !(rowIndex == 0);
        self.leftLine.hidden = !(colIndex == 0);
    } else {
        self.topLine.hidden = YES;
        self.leftLine.hidden = YES;
        self.bottomLine.hidden = YES;
        self.rightLine.hidden = YES;
    }
}

@end
