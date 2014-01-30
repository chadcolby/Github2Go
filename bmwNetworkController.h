//
//  bmwNetworkController.h
//  Github2Go
//
//  Created by Chad D Colby on 1/29/14.
//  Copyright (c) 2014 kramerica. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bmwNetworkController : NSObject

+ (bmwNetworkController *)sharedController;

- (NSArray *)usersSearchArray:(NSString *)searchString;
- (NSArray *)reposSearchArray:(NSString *)searchString;

@end
