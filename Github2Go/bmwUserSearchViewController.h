//
//  bmwUserSearchViewController.h
//  Github2Go
//
//  Created by Chad D Colby on 1/29/14.
//  Copyright (c) 2014 kramerica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bmwWebViewController.h"


@interface bmwUserSearchViewController : UIViewController <UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *usersSearchBar;
@property (strong, nonatomic) bmwWebViewController *webView;

@end
