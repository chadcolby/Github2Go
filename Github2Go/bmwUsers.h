//
//  bmwUsers.h
//  Github2Go
//
//  Created by Chad D Colby on 1/30/14.
//  Copyright (c) 2014 kramerica. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bmwUsers : NSObject

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *avatarURL;
@property (strong, nonatomic) UIImage *profilePicture;
@property (readwrite, nonatomic) BOOL pictureIsDownloading;
@property (weak, nonatomic) NSOperationQueue *downloadQueue;

- (void)downloadProfilePicture;

@end
