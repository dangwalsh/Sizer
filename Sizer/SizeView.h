//
//  SizeView.h
//  Sizer
//
//  Created by Daniel Walsh on 3/23/13.
//  Copyright (c) 2013 Daniel Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SizeViewController.h"

@interface SizeView : UIView

- (id) initWithFrame: (CGRect)frame controller: (SizeViewController *)c;

@property (nonatomic, weak) SizeViewController *delegate;
@property (nonatomic, strong) UIButton *small;
@property (nonatomic, strong) UIButton *medium;
@property (nonatomic, strong) UIButton *large;

@end