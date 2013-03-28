//
//  DropboxDelegate.m
//  Sizer
//
//  Created by Daniel Walsh on 3/27/13.
//  Copyright (c) 2013 Daniel Walsh. All rights reserved.
//

#import "DropboxDelegate.h"
#import "AppDelegate.h"

@implementation DropboxDelegate

- (id) init
{
    self = [super init];
    if (self) {
        // initialize dropbox access
        DBSession* dbSession = [[DBSession alloc] initWithAppKey:@"2hjagbwte1l77cu"
                                                       appSecret:@"pn2z47mxtspkvk1"
                                                            root:kDBRootAppFolder];
        [DBSession setSharedSession:dbSession];
        if (![[DBSession sharedSession] isLinked]) {
            [[DBSession sharedSession] linkFromController:self.delegate];//.window.rootViewController];
        }
    }
    return self;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([[DBSession sharedSession] handleOpenURL:url]) {
        if ([[DBSession sharedSession] isLinked]) {
            NSLog(@"App linked successfully!");
            // At this point you can start making API calls
        }
        return YES;
    }
    // Add whatever other url handling code your app requires here
    return NO;
}

- (DBRestClient *)restClient {
    if (!restClient) {
        restClient =
        [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    return restClient;
}

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    if (metadata.isDirectory) {
        NSLog(@"Folder '%@' contains:", metadata.path);
        for (DBMetadata *file in metadata.contents) {
            NSLog(@"\t%@", file.filename);
        }
    }
}

- (void)restClient:(DBRestClient *)client
loadMetadataFailedWithError:(NSError *)error {
    
    NSLog(@"Error loading metadata: %@", error);
}

- (void) listFiles
{
    [[self restClient] loadMetadata:@"/"];
}

- (void) uploadFile:(NSString *)imageName withPath:(NSString *)pathToFile
{
    //NSString *localPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    //NSString *filename = @"Sizer-Info.plist";
    NSString *destDir = @"/";
    [[self restClient] uploadFile:imageName
                           toPath:destDir
                    withParentRev:nil
                         fromPath:pathToFile];
}

@end
