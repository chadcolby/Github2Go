//
//  bmwUserSearchViewController.m
//  Github2Go
//
//  Created by Chad D Colby on 1/29/14.
//  Copyright (c) 2014 kramerica. All rights reserved.
//

#import "bmwUserSearchViewController.h"
#import "bmwUsersCell.h"
#import "bmwNetworkController.h"

#import "bmwUsers.h"

@interface bmwUserSearchViewController ()

@property (strong, nonatomic) NSArray *searchArray;
@property (strong, nonatomic) NSMutableArray *usersArray;
@property (strong, nonatomic) UIColor *darkColor;

@end

@implementation bmwUserSearchViewController

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

    self.usersSearchBar.delegate = self;
    self.usersCollectionView.delegate = self;
    self.usersCollectionView.dataSource = self;
    self.darkColor = [UIColor colorWithRed:45/255.f green:45/255.f  blue:61/255.f alpha:1.f];
    self.usersCollectionView.backgroundColor = self.darkColor;
    
    self.searchArray = [[NSArray alloc] init];
    self.usersArray = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.searchArray = [[bmwNetworkController sharedController] usersSearchArray:self.usersSearchBar.text];

    [self.usersSearchBar resignFirstResponder];

    [self createUsersArray:self.searchArray];

}

#pragma mark - Collection View Data Source/Delegate Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.usersArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    bmwUsersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    bmwUsers *user = self.usersArray[indexPath.row];
    cell.backgroundColor = self.darkColor;
    cell.userName.text = user.userName;
    
    return cell;

}

#pragma mark - Download methods

- (void)createUsersArray:(NSArray *)arrayToSearch
{
    for (NSDictionary *tempDict in arrayToSearch)
    {
        bmwUsers *user = [[bmwUsers alloc] init];
        user.userName = tempDict[@"login"];
        user.avatarURL = tempDict[@"avatar_url"];
        
        [self.usersArray addObject:user];
        
    }
    
        [self.usersCollectionView reloadData];
}

@end
