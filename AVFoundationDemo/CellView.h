//
//  CellView.h
//  AVFoundationDemo
//
//  Created by CHENG DE LUO on 15/9/17.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CellView;
@protocol CellViewDelegate <NSObject>

@optional
- (void)didSelectedCellView:(CellView *)cellView;

@end

/**
 *  单元格视图
 *
 *  @author apem
 */

@interface CellView : UIView

@property (nonatomic, strong) UIColor *normalBgColor;
@property (nonatomic, strong) UIColor *highlightedBgColor;
@property (nonatomic, strong) UIColor *selectedBgColor;

@property (nonatomic, assign) BOOL canBeSelected; //default is no

@property (nonatomic, assign) id<CellViewDelegate> delegate;

@end
