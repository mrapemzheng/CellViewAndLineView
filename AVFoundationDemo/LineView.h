//
//  LineView.h
//  CloudBuyer
//
//  Created by apple on 15/5/22.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import <UIKit/UIKit.h>

//0.5px的线
//解决xib下最低只能1px的线的问题
//只支持autolayout

@interface LineView : UIView

@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, strong) NSNumber *lineAlignment;      //对齐 0:居中 1:上/左 2:下/右

@end
