//
//  OverlayView.h
//  Sizer
//
//  Created by Daniel Walsh on 3/23/13.
//  Copyright (c) 2013 Daniel Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CameraViewController.h"

@interface OverlayView : UIView

@property (nonatomic, weak) CameraViewController *delegate;
@property (nonatomic, weak) UIButton *pictureButton;
@property (nonatomic, weak) UIButton *lastPicture;
@property (nonatomic, weak) UIButton *flashButton;
@property (nonatomic, weak) UIButton *changeCameraButton;

@end
