//
//  bmwReposSearchViewController.m
//  Github2Go
//
//  Created by Chad D Colby on 1/29/14.
//  Copyright (c) 2014 kramerica. All rights reserved.
//

#import "bmwReposSearchViewController.h"
#import "bmwNetworkController.h"
#import "bmwDetailViewController.h"
#import "bmwWebViewController.h"

@interface bmwReposSearchViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *reposSearchBar;
@property (strong, nonatomic) NSArray *reposArray;
@property (strong, nonatomic) NSDictionary *reposDictionary;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIColor *darkColor;
@property (strong, nonatomic) UIColor *textColor;

@end

@implementation bmwReposSearchViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.reposDictionary = [[NSDictionary alloc] init];
    
    self.reposSearchBar.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.darkColor = [UIColor colorWithRed:45/255.f green:45/255.f  blue:61/255.f alpha:1.f];
    self.textColor = [UIColor colorWithRed:243/255.f green:195/255.f  blue:47/255.f alpha:1.f];
    self.tableView.backgroundColor = self.darkColor;


}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - Searching Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.reposSearchBar becomeFirstResponder];
    self.reposArray = [[NSArray alloc] init];
    
    
    self.reposArray = [[bmwNetworkController sharedController] reposSearchArray:self.reposSearchBar.text];
    [self.reposSearchBar resignFirstResponder];
    [self.tableView reloadData];

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
    return self.reposArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    self.reposDictionary = [self.reposArray objectAtIndex:indexPath.row];
    cell.backgroundColor = self.darkColor;
    cell.textLabel.textColor = self.textColor;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = [self.reposDictionary objectForKey:@"name"];
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushToWeb"]) {
        
    
    bmwWebViewController *destination = [segue destinationViewController];
    destination.htmlString = [[NSString alloc] init];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    self.reposDictionary = [self.reposArray objectAtIndex:indexPath.row];
    destination.htmlString = [self.reposDictionary objectForKey:@"html_url"];
    
    [destination.view addSubview:destination.webView];
    [destination loadWebView:destination.htmlString];
        
     }
}



@end
