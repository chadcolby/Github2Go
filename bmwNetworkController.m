//
//  bmwNetworkController.m
//  Github2Go
//
//  Created by Chad D Colby on 1/29/14.
//  Copyright (c) 2014 kramerica. All rights reserved.
//

#import "bmwNetworkController.h"

@implementation bmwNetworkController

+ (bmwNetworkController *)sharedController
{
    static dispatch_once_t pred;
    static bmwNetworkController *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[bmwNetworkController alloc] init];
    });
    
    return shared;
}

- (NSArray *)usersSearchArray:(NSString *)searchString
{
    searchString = [NSString stringWithFormat:@"https://api.github.com/search/users?q=%@", searchString];
    searchString = [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *searchURL = [NSURL URLWithString:searchString];
    NSData *searchData = [NSData dataWithContentsOfURL:searchURL];
    
    NSError *error;
    NSDictionary *searchDictionary = [NSJSONSerialization JSONObjectWithData:searchData options:NSJSONReadingMutableContainers error:&error];
    
    return searchDictionary[@"items"];
}

- (NSArray *)reposSearchArray:(NSString *)searchString
{
    searchString = [NSString stringWithFormat:@"https://api.github.com/search/repositories?q=%@", searchString];
    searchString = [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *searchURL = [NSURL URLWithString:searchString];
    NSData *searchData = [NSData dataWithContentsOfURL:searchURL];
    
    NSError *error;
    NSDictionary *searchDictionary = [NSJSONSerialization JSONObjectWithData:searchData options:NSJSONReadingMutableContainers error:&error];
    
    return searchDictionary[@"items"];
}
@end
