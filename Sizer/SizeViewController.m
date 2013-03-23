//
//  SizeViewController.m
//  Sizer
//
//  Created by Daniel Walsh on 3/23/13.
//  Copyright (c) 2013 Daniel Walsh. All rights reserved.
//

#import "SizeViewController.h"
#import "SizeView.h"

@interface SizeViewController ()

@end

@implementation SizeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadView
{
	CGRect frame = [UIScreen mainScreen].applicationFrame;
	self.view = [[SizeView alloc] initWithFrame:frame controller:self];
}

- (void) dismiss
{
    void (^presPicker)(void);
    presPicker = ^(void) {
        [self.delegate showCamera];
    };
    [self.presentingViewController dismissViewControllerAnimated:YES completion:presPicker];
}

@end
