//
//  LineView.m
//  CloudBuyer
//
//  Created by apple on 15/5/22.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "LineView.h"
#import "UIView+Utils.h"
#import "Masonry.h"

@interface LineView ()

@property (nonatomic, strong) UIView *containView;

@end

@implementation LineView

- (void)awakeFromNib
{
    [self autolayoutSetup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

#pragma mark - private methods

//自动布局下的setup
- (void)autolayoutSetup
{
    _lineHeight = 0.5;
    UIColor *color = self.backgroundColor;
    self.backgroundColor = [UIColor clearColor];
    CGSize size = self.size;

    self.containView = [[UIView alloc] initWithFrame:CGRectZero];
    self.containView.backgroundColor = color;
    [self addSubview:self.containView];
    
    __weak typeof(self) ws = self;
    if (size.width > size.height) {
        
        //居中
        if ([self.lineAlignment integerValue] == 0) {
            [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(0);
                make.right.offset(0);
                make.height.offset(ws.lineHeight);
                make.centerY.offset(0);
            }];
        //上/左
        } else if ([self.lineAlignment integerValue] == 1) {
            [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(0);
                make.right.offset(0);
                make.height.offset(ws.lineHeight);
                make.top.offset(0);
            }];
        //下/右
        } else if ([self.lineAlignment integerValue] == 2) {
            [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(0);
                make.right.offset(0);
                make.height.offset(ws.lineHeight);
                make.bottom.offset(0);
            }];
        }
        
    } else {
        
        //居中
        if ([self.lineAlignment integerValue] == 0) {
            [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(0);
                make.bottom.offset(0);
                make.width.offset(ws.lineHeight);
                make.centerX.offset(0);
            }];
            //上/左
        } else if ([self.lineAlignment integerValue] == 1) {
            [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(0);
                make.bottom.offset(0);
                make.width.offset(ws.lineHeight);
                make.left.offset(0);
            }];
            //下/右
        } else if ([self.lineAlignment integerValue] == 2) {
            [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(0);
                make.bottom.offset(0);
                make.width.offset(ws.lineHeight);
                make.right.offset(0);
            }];
        }
        
        
    }
}

//frame布局的setup
- (void)setup
{
    _lineHeight = 0.5;
    UIColor *color = self.backgroundColor;
    self.backgroundColor = [UIColor clearColor];
    CGSize size = self.size;
    CGFloat w;
    CGFloat h;
    if (size.width > size.height) {
        w = size.width;
        h = self.lineHeight;
    } else {
        w = self.lineHeight;
        h = size.height;
    }
    self.containView = [[UIView alloc] initWithFrame:CGRectMake((size.width - w)/2, (size.height - h)/2, w, h)];
    self.containView.backgroundColor = color;
    [self addSubview:self.containView];
    
}


@end
