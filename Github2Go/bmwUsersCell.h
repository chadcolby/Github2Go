//
//  bmwUsersCell.h
//  Github2Go
//
//  Created by Chad D Colby on 1/30/14.
//  Copyright (c) 2014 kramerica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bmwUsersCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) NSString *userImageURL;
@property (weak, nonatomic) UIColor *textColor;
@property (readwrite, nonatomic) BOOL currentlyDownloading;


@end
