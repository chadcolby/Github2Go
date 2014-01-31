//
//  bmwUsers.m
//  Github2Go
//
//  Created by Chad D Colby on 1/30/14.
//  Copyright (c) 2014 kramerica. All rights reserved.
//

#import "bmwUsers.h"

@implementation bmwUsers

- (UIImage *)downloadPicture
{
    self.currenlyDownloadingPicture = YES;
    
    [self.downloadQueue addOperationWithBlock:^{
        
        NSData *imageData = [NSData dataWithContentsOfFile:self.avatarURL];
        
        self.userImage = [UIImage imageWithData:imageData];
        
    }];
    
    return self.userImage;
}

@end
