//
//  SizeView.h
//  Sizer
//
//  Created by Daniel Walsh on 3/23/13.
//  Copyright (c) 2013 Daniel Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraViewController.h"

@interface SizeView : UIView

@property (nonatomic, weak) CameraViewController *delegate;
@property (nonatomic, strong) UILabel *small;
@property (nonatomic, strong) UILabel *medium;
@property (nonatomic, strong) UILabel *large;
@property (nonatomic, strong) UISlider *custom;

@end
