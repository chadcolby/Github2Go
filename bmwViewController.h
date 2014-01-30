//
//  bmwViewController.h
//  Github2Go
//
//  Created by Chad D Colby on 1/29/14.
//  Copyright (c) 2014 kramerica. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideViewController <NSObject>

- (void)openMenu;
- (void)closeMenu;

@end

@interface bmwViewController : UIViewController

@property (unsafe_unretained) id <SlideViewController> delegate;

@end
