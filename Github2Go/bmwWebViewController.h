//
//  bmwWebViewController.h
//  Github2Go
//
//  Created by Chad D Colby on 1/29/14.
//  Copyright (c) 2014 kramerica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bmwWebViewController : UIViewController

@property (strong, nonatomic) NSString *htmlString;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (void)loadWebView:(NSString *)string;

@end
