//
//  CameraViewController.h
//  Sizer
//
//  Created by Daniel Walsh on 3/23/13.
//  Copyright (c) 2013 Daniel Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
//#import <QuartzCore/QuartzCore.h>

@interface CameraViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIScrollView *scrollView;
    UIImageView *imageView;
    NSMutableArray *assets;
}

@property (nonatomic, strong) UIImagePickerController *picker;

- (void) present;
- (void) changeFlash:(id)sender;
- (void) changeCamera;
- (void) showLibrary;
- (void) showCamera;
- (void) hideCamera;
- (void) takePicture;

@end
