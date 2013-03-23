//
//  OverlayView.m
//  Sizer
//
//  Created by Daniel Walsh on 3/23/13.
//  Copyright (c) 2013 Daniel Walsh. All rights reserved.
//

#import "OverlayView.h"
#import "SizeViewController.h"

@implementation OverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code   
        self.opaque = NO;
        UIImage *buttonImageNormal;
        
        // Add the flash button
        if ([UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear]) {
            self.flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.flashButton.frame = CGRectMake(10, 0, 57.5, 57.5);
            buttonImageNormal = [UIImage imageNamed:@"flash02"];
            [self.flashButton setImage:buttonImageNormal forState:UIControlStateNormal];
            [self.flashButton addTarget:self action:@selector(setFlash:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.flashButton];
        }
        
        // Add the camera button
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            self.changeCameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.changeCameraButton.frame = CGRectMake(250, 0, 57.5, 57.5);
            buttonImageNormal = [UIImage imageNamed:@"switch_button"];
            [self.changeCameraButton setImage:buttonImageNormal forState:UIControlStateNormal];
            [self.changeCameraButton addTarget:self action:@selector(changeCamera:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.changeCameraButton];
        }
        
        // Add the bottom bar
        CGRect frame = CGRectMake(0, self.bounds.size.height - 95, 320, 95);
        UIView *bottomBar = [[UIView alloc] initWithFrame:frame];
        CAGradientLayer *grad = [CAGradientLayer layer];
        grad.frame = bottomBar.bounds;
        grad.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.0f] CGColor],
                       (id)[[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f] CGColor],
                       (id)[[UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:1.0f] CGColor],
                       (id)[[UIColor colorWithRed:0.04f green:0.04f blue:0.04f alpha:1.0f] CGColor],
                       (id)[[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f] CGColor],
                       nil];
        grad.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f],
                          [NSNumber numberWithFloat:0.02f],
                          [NSNumber numberWithFloat:0.5f],
                          [NSNumber numberWithFloat:0.5f],
                          [NSNumber numberWithFloat:1.0f],
                          nil];
        [bottomBar.layer insertSublayer:grad atIndex:0];
        [self addSubview:bottomBar];
        
        // Add the capture button
        buttonImageNormal = [UIImage imageNamed:@"take_picture"];
        self.pictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.pictureButton.frame = CGRectMake(90, self.bounds.size.height - 95, 130, 100);
        self.pictureButton.layer.opacity = 0.5f;
        [self.pictureButton setImage:buttonImageNormal forState:UIControlStateNormal];
        [self.pictureButton setImage:buttonImageNormal forState:UIControlStateDisabled];
        [self.pictureButton addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.pictureButton];
        
        // Add the gallery button
        self.lastPicture = [UIButton buttonWithType:UIButtonTypeCustom];
        self.lastPicture.frame = CGRectMake(20, self.bounds.size.height - 70, 50, 50);
        self.lastPicture.layer.masksToBounds = YES;
        self.lastPicture.layer.cornerRadius = 6.0f;
        self.lastPicture.layer.borderWidth = 0.5f;
        self.lastPicture.layer.borderColor = [[UIColor grayColor] CGColor];
        [self.lastPicture addTarget:self action:@selector(showCameraRoll:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.lastPicture];
    }
    return self;
}

- (void)takePicture:(id)sender
{
    self.pictureButton.enabled = NO;
    [self.delegate takePicture];
    [self.delegate hideCamera];
}

- (void)setFlash:(id)sender
{
    [self.delegate changeFlash:sender];
}

- (void)changeCamera:(id)sender
{
    [self.delegate changeCamera];
}

- (void)showCameraRoll:(id)sender
{
    [self.delegate showLibrary];
}
/*
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate present];
}
*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
