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
@property (strong, nonatomic) UIImage *userImage;
@property (strong, nonatomic) NSString *avatarURL;
@property (weak, nonatomic) NSOperationQueue *downloadQueue;
@property (readwrite, nonatomic) BOOL currenlyDownloadingPicture;

- (UIImage *)downloadPicture;


@end
