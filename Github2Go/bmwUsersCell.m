//
//  bmwUsersCell.m
//  Github2Go
//
//  Created by Chad D Colby on 1/30/14.
//  Copyright (c) 2014 kramerica. All rights reserved.
//

#import "bmwUsersCell.h"

@interface bmwUsersCell ()

@property (strong, nonatomic) UIActivityIndicatorView *statusView;

@end

@implementation bmwUsersCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {


    }
    return self;
}


- (void)searchIsDownloading:(BOOL)currentlyDownloading
{
    self.currentlyDownloading = YES;
    if (currentlyDownloading) {
        self.statusView = [[UIActivityIndicatorView alloc] initWithFrame:self.contentView.frame];
        [self.contentView addSubview:self.statusView];
        [self.statusView startAnimating];
    } else {
        [self.statusView stopAnimating];
        [self.statusView removeFromSuperview];
    }
}


@end
