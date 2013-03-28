//
//  DropboxDelegate.h
//  Sizer
//
//  Created by Daniel Walsh on 3/27/13.
//  Copyright (c) 2013 Daniel Walsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DropboxSDK/DropboxSDK.h>

@class AppDelegate;

@interface DropboxDelegate : NSObject {
    DBRestClient *restClient;
}

//@property (nonatomic, weak) AppDelegate *delegate;
@property (nonatomic, weak) UIViewController *delegate;

- (void) listFiles;
- (void) uploadFile:(NSString *)imageName withPath:(NSString *)pathToFile;

@end
