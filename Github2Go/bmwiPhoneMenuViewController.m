//
//  bmwiPhoneMenuViewController.m
//  Github2Go
//
//  Created by Chad D Colby on 1/29/14.
//  Copyright (c) 2014 kramerica. All rights reserved.
//

#import "bmwiPhoneMenuViewController.h"
#import "bmwUserSearchViewController.h"
#import "bmwReposSearchViewController.h"

@interface bmwiPhoneMenuViewController ()

@property (strong, nonatomic) bmwViewController *slideVC;
@property (strong, nonatomic) bmwUserSearchViewController *usersSearch;
@property (strong, nonatomic) bmwReposSearchViewController *reposSearch;

@end

@implementation bmwiPhoneMenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.menuArray = [NSArray arrayWithObjects:@"MENU", @"Profile", @"Users", @"Repos", @"Help", nil];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    [self createViewController];
    [self panGestureSetUp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Set Up Slide View Controller

- (void)createViewController
{
    self.slideVC = [self.storyboard instantiateViewControllerWithIdentifier:@"slideViewController"];
    //[self.slideVC setDelegate:self];
    self.slideVC.view.backgroundColor = [UIColor blackColor];
    self.slideVC.view.alpha = 0.88;
    
    [self addChildViewController:self.slideVC];
    self.slideVC.view.frame = self.tableView.frame;
    [self.view addSubview:self.slideVC.view];
    [self.slideVC didMoveToParentViewController:self];
}

- (void)panGestureSetUp
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slideToMenu:)];
    panGesture.minimumNumberOfTouches = 1;
    panGesture.maximumNumberOfTouches = 1;
    panGesture.delegate = self;
    
    [self.slideVC.view addGestureRecognizer:panGesture];
    
}
#pragma mark - Slide View Methods

- (void)slideToMenu:(id)sender
{
    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)sender;
    
    //    CGPoint velocity = [panGesture velocityInView:self.view];
    CGPoint trans = [panGesture translationInView:self.view];
    
    // Check to make sure the gesture is to the right to revel menu.
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        
        if(self.slideVC.view.frame.origin.x + trans.x > 0) {
            self.slideVC.view.center = CGPointMake(self.slideVC.view.center.x + trans.x, self.slideVC.view.center.y);
            
            [(UIPanGestureRecognizer *)sender setTranslation:CGPointMake(0, 0) inView:self.view];
        }
    }
    
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        
        if (self.slideVC.view.frame.origin.x > self.tableView.frame.size.width / 3) {
            [self openMenu];
        }
        
        if (self.slideVC.view.frame.origin.x < self.tableView.frame.size.width / 3) {
            
            [UIView animateWithDuration:.4 animations:^{
                self.slideVC.view.frame = self.view.frame;
            } completion:^(BOOL finished) {
                [self closeMenu];
            }];
        }
    }
}

- (void)openMenu
{
    [UIView animateWithDuration:.4 animations:^{
        self.slideVC.view.frame = CGRectMake(self.tableView.frame.size.width * .69, self.slideVC.view.frame.origin.y,
                                             self.slideVC.view.frame.size.width, self.slideVC.view.frame.size.height);
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(slideBack:)];
        [self.slideVC.view addGestureRecognizer:tap];
    }];

}

- (void)closeMenu
{
    [UIView animateWithDuration:.15 animations:^{
        self.slideVC.view.frame = CGRectMake(self.slideVC.view.frame.origin.x + 6.f, self.slideVC.view.frame.origin.y,
                                             self.slideVC.view.frame.size.width, self.slideVC.view.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.1 animations:^{
            self.slideVC.view.frame = self.view.frame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.075 animations:^{
                self.slideVC.view.frame = CGRectMake(self.slideVC.view.frame.origin.x + 3.f, self.slideVC.view.frame.origin.y,
                                                     self.slideVC.view.frame.size.width, self.slideVC.view.frame.size.height);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:.033 animations:^{
                    self.slideVC.view.frame = self.view.frame;
                }];
            }];
        }];
    }];
    
}

- (void)slideBack:(id)sender
{
    [UIView animateWithDuration:.2 animations:^{
        self.slideVC.view.frame = self.view.frame;
    } completion:^(BOOL finished) {
        [self.slideVC.view removeGestureRecognizer:(UITapGestureRecognizer *)sender];
        
        [self closeMenu];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    cell.textLabel.text = [self.menuArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Courier" size:17.0f];
    cell.backgroundColor = [UIColor lightGrayColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.f;
}


#pragma mark - Navigation
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //bmwUserSearchViewController *usersSearchViewController = [[bmwUserSearchViewController alloc] init];
    switch (indexPath.row) {
  case 2:
            self.usersSearch = [self.storyboard instantiateViewControllerWithIdentifier:@"usersSearch"];
            
            [self addChildViewController:self.usersSearch];
            self.usersSearch.view.frame = self.tableView.frame;
            [self.view addSubview:self.usersSearch.view];
            [self.usersSearch didMoveToParentViewController:self];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    break;
case 3:
            self.reposSearch = [self.storyboard instantiateViewControllerWithIdentifier:@"reposSearch"];
            [self addChildViewController:self.reposSearch];
            self.reposSearch.view.frame = self.tableView.frame;
            [self.view addSubview:self.reposSearch.view];
            [self.reposSearch didMoveToParentViewController:self];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
            
  default:
    break;
}
    
}


@end
