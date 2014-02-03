//
//  bmwUsers.m
//  Github2Go
//
//  Created by Chad D Colby on 1/30/14.
//  Copyright (c) 2014 kramerica. All rights reserved.
//

#import "bmwUsers.h"

@implementation bmwUsers

- (void)downloadProfilePicture
{
 
    self.pictureIsDownloading = YES;
    
    [self.downloadQueue addOperationWithBlock:^{
        NSData *pictureData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.avatarURL]];
        self.profilePicture = [UIImage imageWithData:pictureData];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:DOWNLOADING object:nil userInfo:@{@"user": self}];
        }];
    }];
}

@end
