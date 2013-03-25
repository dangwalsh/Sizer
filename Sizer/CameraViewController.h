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
    ALAsset *lastPicture;
    UIImage *thisImage;
}

@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, strong) UIView *sizeView;
@property (nonatomic, strong) UILabel *small;
@property (nonatomic, strong) UILabel *medium;
@property (nonatomic, strong) UILabel *large;
@property (nonatomic, strong) UISlider *custom;

- (void) present;
- (void) changeFlash:(id)sender;
- (void) changeCamera;
- (void) showLibrary;
- (void) showCamera;
- (void) sizeImage;
- (void) takePicture;
- (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSize:(CGSize)newSize;
- (void) makeSmall;
- (void) makeMedium;
- (void) makeLarge;
- (void) makeCustom;

@end
