//
//  SizeViewController.h
//  Sizer
//
//  Created by Daniel Walsh on 3/23/13.
//  Copyright (c) 2013 Daniel Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraViewController.h"

@interface SizeViewController : UIViewController

@property (nonatomic,weak) CameraViewController *delegate;

- (void) dismiss;

@end
