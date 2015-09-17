//
//  CellView.m
//  AVFoundationDemo
//
//  Created by CHENG DE LUO on 15/9/17.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "CellView.h"

@implementation CellView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initConfig];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self initConfig];
        [self setup];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    self.backgroundColor = self.highlightedBgColor;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    self.backgroundColor = self.normalBgColor;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //选中
    if (CGRectContainsPoint(self.bounds, point)) {
        if (self.canBeSelected) {
            self.backgroundColor = self.selectedBgColor;
        } else {
            
            //发送委托
            if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedCellView:)]) {
                [self.delegate didSelectedCellView:self];
            }
            
            [UIView animateWithDuration:0.3 animations:^{
                self.backgroundColor = self.normalBgColor;
            }];
        }
    
    //取消
    } else {
        self.backgroundColor = self.normalBgColor;
    }
}

#pragma mark - private methods

- (void)setup
{
    
}

- (void)initConfig
{
    if(!self.normalBgColor) {
        self.normalBgColor = self.backgroundColor;
    } else {
        self.backgroundColor = self.normalBgColor;
    }
    
    if(!self.highlightedBgColor) self.highlightedBgColor = [UIColor grayColor];
    if(!self.selectedBgColor) self.selectedBgColor = self.highlightedBgColor;
    if(!self.canBeSelected) self.canBeSelected = NO;
    
}

@end
