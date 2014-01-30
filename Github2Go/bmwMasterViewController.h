//
//  bmwMasterViewController.h
//  Github2Go
//
//  Created by Chad D Colby on 1/29/14.
//  Copyright (c) 2014 kramerica. All rights reserved.
//

#import <UIKit/UIKit.h>

@class bmwDetailViewController;

@interface bmwMasterViewController : UITableViewController

@property (strong, nonatomic) bmwDetailViewController *detailViewController;

@end
