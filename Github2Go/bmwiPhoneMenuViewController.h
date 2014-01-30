//
//  bmwiPhoneMenuViewController.h
//  Github2Go
//
//  Created by Chad D Colby on 1/29/14.
//  Copyright (c) 2014 kramerica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bmwViewController.h"

@interface bmwiPhoneMenuViewController : UITableViewController <SlideViewController, UIGestureRecognizerDelegate>

@property (strong, nonatomic) NSArray *menuArray;

- (void)openMenu;
- (void)closeMenu;

@end
