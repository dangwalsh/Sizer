//
//  CameraViewController.m
//  Sizer
//
//  Created by Daniel Walsh on 3/23/13.
//  Copyright (c) 2013 Daniel Walsh. All rights reserved.
//

#import "CameraViewController.h"
#import "OverlayView.h"
#import "SizeViewController.h"

@interface CameraViewController () {
    SizeViewController *sizeController;
    OverlayView *overlay;
    BOOL didCancel;
}

@end

@implementation CameraViewController

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
    overlay = [[OverlayView alloc] initWithFrame:frame];
    overlay.delegate = self;
	self.view = overlay;
    
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    self.picker.navigationBarHidden = YES;
    self.picker.toolbarHidden = YES;
    self.picker.wantsFullScreenLayout = YES;

    void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result) {
            [assets addObject:result];
            
        } else {
            [self performSelectorOnMainThread:@selector(showCamera) withObject:nil waitUntilDone:NO];
            lastPicture = (ALAsset *)[assets lastObject];
            [overlay.lastPicture setImage:[UIImage imageWithCGImage:[lastPicture thumbnail]] forState:UIControlStateNormal];
        }
    };
    
    void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) =  ^(ALAssetsGroup *group, BOOL *stop) {
        if(group) {
            [group enumerateAssetsUsingBlock:assetEnumerator];
        }
    };
    
    assets = [[NSMutableArray alloc] init];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                           usingBlock:assetGroupEnumerator
                         failureBlock: ^(NSError *error) {
                             NSLog(@"Failure");
                         }];

}

- (void) imagePickerController:(UIImagePickerController *)aPicker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *aImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    thisImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (aPicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum (aImage, nil, nil , nil);
        overlay.pictureButton.enabled = YES;
        [overlay.lastPicture setImage:aImage forState:UIControlStateNormal];
    } else {
        // clear the previous imageView
        [imageView removeFromSuperview];
        imageView = nil;
        
        // reset our zoomScale
        CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
        imageView = [[UIImageView alloc] initWithImage:aImage];
        scrollView.contentSize = aImage.size;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        
        // set up our content size and min/max zoomscale
        CGFloat xScale = applicationFrame.size.width / aImage.size.width;    // the scale needed to perfectly fit the image width-wise
        CGFloat yScale = applicationFrame.size.height / aImage.size.height;  // the scale needed to perfectly fit the image height-wise
        CGFloat minScale = MIN(xScale, yScale);                 // use minimum of these to allow the image to become fully visible
        
        // on high resolution screens we have double the pixel density, so we will be seeing every pixel if we limit the
        // maximum zoom scale to 0.5.
        CGFloat maxScale = 1.0 / [[UIScreen mainScreen] scale];
        
        // don't let minScale exceed maxScale. (If the image is smaller than the screen, we don't want to force it to be zoomed.)
        if (minScale > maxScale) {
            minScale = maxScale;
        }
        
        scrollView.contentSize = aImage.size;
        scrollView.maximumZoomScale = maxScale;
        scrollView.minimumZoomScale = minScale;
        scrollView.zoomScale = minScale;
        
        
        //////////////
        
        CGSize boundsSize = applicationFrame.size;
        CGRect frameToCenter = imageView.frame;
        
        // center horizontally
        if (frameToCenter.size.width < boundsSize.width)
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
        else
            frameToCenter.origin.x = 0;
        
        // center vertically
        if (frameToCenter.size.height < boundsSize.height)
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
        else
            frameToCenter.origin.y = 0;
        
        //////////////
        
        imageView.frame = frameToCenter;
        
        [scrollView addSubview:imageView];
        
        [self.picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void) showCamera
{
    self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Must be NO.
    self.picker.showsCameraControls = NO;
    
    self.picker.cameraViewTransform =
    CGAffineTransformScale(self.picker.cameraViewTransform, 1, 1);
    
    // When showCamera is called, it will show by default the back camera, so if the flashButton was hidden because the user switched to the front camera, you have to show it again.
    if (overlay.flashButton.hidden) {
        overlay.flashButton.hidden = NO;
    }
    
    self.picker.cameraOverlayView = overlay;
    
    // If the user cancelled the selection of an image in the camera roll, we have to call this method again.
    if (!didCancel) {
        [self presentViewController:self.picker animated:YES completion:nil];
    } else {
        didCancel = NO;
    }
}

- (void) hideCamera
{
    /*
    void (^presSize)(void);
    presSize = ^(void) {
        sizeController = [[SizeViewController alloc]initWithNibName:nil bundle:nil];
        sizeController.delegate = self;
        [self presentViewController:sizeController animated:YES completion:nil];
    };
    [self dismissViewControllerAnimated:YES completion:presSize];
    */
    
    self.sizeView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.sizeView.opaque = NO;
    self.sizeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    CGSize s = CGSizeMake(150, 50);
    CGRect f1 = CGRectMake((frame.size.width - s.width) / 2,
                           (frame.size.height - s.height) / 6,
                           s.width,
                           s.height);
    self.small = [[UILabel alloc] init];    
    self.small.text = @"Small";
    self.small.textAlignment = UITextAlignmentCenter;
    self.small.textColor = [UIColor whiteColor];
    self.small.backgroundColor = [UIColor clearColor];
    self.small.opaque = NO;
    self.small.userInteractionEnabled = YES;
    UITapGestureRecognizer *smallTap = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(makeSmall:)];
    [self.small addGestureRecognizer:smallTap];    
    self.small.frame = f1;
    [self.sizeView addSubview:self.small];
    CGRect f2 = CGRectMake((frame.size.width - s.width) / 2,
                           ((frame.size.height - s.height) / 6) * 2,
                           s.width,
                           s.height);
    self.medium = [[UILabel alloc] init];
    self.medium.text = @"Medium";
    self.medium.textAlignment = UITextAlignmentCenter;
    self.medium.textColor = [UIColor whiteColor];
    self.medium.backgroundColor = [UIColor clearColor];
    self.medium.opaque = NO;
    self.medium.userInteractionEnabled = YES;
    self.medium.frame = f2;
    self.medium.userInteractionEnabled = YES;
    UITapGestureRecognizer *mediumTap = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(makeMedium:)];
    [self.medium addGestureRecognizer:mediumTap];
    [self.sizeView addSubview:self.medium];
    CGRect f3 = CGRectMake((frame.size.width - s.width) / 2,
                           ((frame.size.height - s.height) / 6) * 3,
                           s.width,
                           s.height);
    self.large = [[UILabel alloc] init];
    self.large.text = @"Large";
    self.large.textAlignment = UITextAlignmentCenter;
    self.large.textColor = [UIColor whiteColor];
    self.large.backgroundColor = [UIColor clearColor];
    self.large.opaque = NO;
    self.large.userInteractionEnabled = YES;
    self.large.frame = f3;
    self.large.userInteractionEnabled = YES;
    UITapGestureRecognizer *largeTap = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(makeLarge:)];
    [self.large addGestureRecognizer:largeTap];
    [self.sizeView addSubview:self.large];
    CGRect f4 = CGRectMake((frame.size.width - s.width) / 2,
                           ((frame.size.height - s.height) / 6) * 4,
                           s.width,
                           s.height);
    self.custom = [[UISlider alloc]initWithFrame:f4];
    self.custom.minimumValue = 1;
    self.custom.maximumValue = 99;
    self.custom.value = (self.custom.maximumValue + self.custom.minimumValue) / 2;
    self.custom.continuous = YES;
    self.custom.backgroundColor = [UIColor clearColor];
    self.custom.minimumTrackTintColor = [UIColor whiteColor];
    self.custom.maximumTrackTintColor = [UIColor clearColor];
    self.custom.opaque = NO;
    UITapGestureRecognizer *customTap = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(processImage:)];
    [self.custom addGestureRecognizer:customTap];
    [self.sizeView addSubview:self.custom];
    
    [self.view addSubview:self.sizeView];
    /*[UIView transitionFromView:self.view
                        toView:self.sizeView
                      duration:2.25
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    completion:NULL];*/
}

- (void) makeSmall: (id)sender
{
    UIImage *newImage = [self imageWithImage:thisImage  scaledToSize:CGSizeMake(640, 480)];
    UIImageWriteToSavedPhotosAlbum (newImage, nil, nil , nil);
    [self.sizeView removeFromSuperview];
}

- (void) makeMedium: (id)sender
{
    UIImage *newImage = [self imageWithImage:thisImage  scaledToSize:CGSizeMake(1024, 768)];
    UIImageWriteToSavedPhotosAlbum (newImage, nil, nil , nil);
    [self.sizeView removeFromSuperview];
}

- (void) makeLarge: (id)sender
{
    UIImage *newImage = [self imageWithImage:thisImage  scaledToSize:CGSizeMake(1920, 1080)];
    UIImageWriteToSavedPhotosAlbum (newImage, nil, nil , nil);
    [self.sizeView removeFromSuperview];
}

- (void) takePicture
{
    [self.picker takePicture];
}

- (void) changeFlash:(id)sender
{
    switch (self.picker.cameraFlashMode) {
        case UIImagePickerControllerCameraFlashModeAuto:
            [(UIButton *)sender setImage:[UIImage imageNamed:@"flash01"] forState:UIControlStateNormal];
            self.picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
            break;
            
        case UIImagePickerControllerCameraFlashModeOn:
            [(UIButton *)sender setImage:[UIImage imageNamed:@"flash03"] forState:UIControlStateNormal];
            self.picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
            break;
            
        case UIImagePickerControllerCameraFlashModeOff:
            [(UIButton *)sender setImage:[UIImage imageNamed:@"flash02"] forState:UIControlStateNormal];
            self.picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
            break;
    }
}

- (void)changeCamera
{
    if (self.picker.cameraDevice == UIImagePickerControllerCameraDeviceFront) {
        self.picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        overlay.flashButton.hidden = NO;
    } else {
        self.picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        overlay.flashButton.hidden = YES;
    }
}

- (void)showLibrary
{
    self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
}

- (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSize:(CGSize)newSize
{
    CGFloat targetWidth = newSize.width;
    CGFloat targetHeight = newSize.height;
    
    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
    if (bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }
    
    CGContextRef bitmap;
    
    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    } else {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    }
    
    if (sourceImage.imageOrientation == UIImageOrientationLeft) {
        CGContextRotateCTM (bitmap, M_PI_2); // + 90 degrees
        CGContextTranslateCTM (bitmap, 0, -targetHeight);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationRight) {
        CGContextRotateCTM (bitmap, -M_PI_2); // - 90 degrees
        CGContextTranslateCTM (bitmap, -targetWidth, 0);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationUp) {
        // NOTHING
    } else if (sourceImage.imageOrientation == UIImageOrientationDown) {
        CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
        CGContextRotateCTM (bitmap, -M_PI); // - 180 degrees
    }
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, targetWidth, targetHeight), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage; 
}

@end
