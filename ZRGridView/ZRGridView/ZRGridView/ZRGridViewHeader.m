//
//  ZRGridViewHeader.m
//  ZRGridView
//
//  Created by jiaxw-mac on 2017/4/29.
//  Copyright © 2017年 jiaxw32. All rights reserved.
//

#import "ZRGridViewHeader.h"

@interface ZRGridViewHeader ()

@property (nonatomic,strong) NSMutableArray *fieldsButton;

@end

@implementation ZRGridViewHeader

- (instancetype)init{
    if (self = [super init]) {
        _fieldsButton = [NSMutableArray new];
    }
    return self;
}

- (void)setFields:(NSArray *)fields andWidths:(NSArray *)widths{
    _fields = fields;
    
    UIView *contentView = self;
    contentView.backgroundColor = [UIColor whiteColor];
    [contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_fieldsButton removeAllObjects];
    __block UIButton *preButton;
    __weak typeof(self) weakSelf = self;
    [_fields enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = idx;
        btn.backgroundColor = weakSelf.headerBackgroudColor;
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitleColor:weakSelf.fieldTitleColor forState:UIControlStateNormal];
        [btn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [contentView addSubview:btn];
        [btn addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat width = 0;
        if (idx < widths.count) {
            width = [widths[idx] floatValue];
        }
        
        NSDictionary *metrics = @{@"margin":@1.0f,@"width":@((width-1.0) >= 0 ? (width - 1.0) : 0)};
        NSString *vflV = @"V:|-0-[btn]-0-|";
        NSString *vflH = @"H:|-0-[btn(width)]";
        if (preButton) {
            NSString *vflH = @"H:[preButton]-margin-[btn(width)]";
            [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflH options:0 metrics:metrics views:NSDictionaryOfVariableBindings(btn,preButton)]];
            [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflV options:0 metrics:metrics views:NSDictionaryOfVariableBindings(btn)]];
        } else {
            [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflH options:0 metrics:metrics views:NSDictionaryOfVariableBindings(btn)]];
            [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflV options:0 metrics:metrics views:NSDictionaryOfVariableBindings(btn)]];
        }
        preButton = btn;
        [_fieldsButton addObject:btn];
    }];
}

- (void)onButtonClicked:(UIButton *)sender{
    if (_columnClickHandler) {
        _columnClickHandler(sender,sender.tag);
    }
}


@end
