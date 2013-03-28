//
//  AppDelegate.h
//  Sizer
//
//  Created by Daniel Walsh on 3/23/13.
//  Copyright (c) 2013 Daniel Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>

@class DropboxDelegate;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    DropboxDelegate *dropbox;
}

@property (strong, nonatomic) UIWindow *window;

@end
