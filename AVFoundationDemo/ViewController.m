//
//  ViewController.m
//  AVFoundationDemo
//
//  Created by CHENG DE LUO on 15/9/15.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CellView.h"

@interface ViewController ()<CellViewDelegate>
@property (weak, nonatomic) IBOutlet CellView *cellView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.cellView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CellViewDelegate

- (void)didSelectedCellView:(CellView *)cellView
{
    NSLog(@"%s:%@", __func__, cellView.description);
}

@end
