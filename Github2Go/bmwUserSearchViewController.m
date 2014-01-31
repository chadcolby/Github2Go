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

@interface bmwUserSearchViewController ()

@property (strong, nonatomic) NSMutableArray *userArray;

@end

@implementation bmwUserSearchViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self) {
        
        self.usersCollectionView.backgroundColor = [UIColor greenColor];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.usersSearchBar.delegate = self;
    self.usersCollectionView.delegate = self;
    self.usersCollectionView.dataSource = self;
    
    
    self.userArray = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.userArray = [[bmwNetworkController sharedController] usersSearchArray:self.usersSearchBar.text];
    NSLog(@"Users: %@", self.userArray);
    
}

#pragma mark - Collection View Data Source/Delegate Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.userArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    bmwUsersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];

    cell.userName.text = self.userArray[indexPath.row];
  
    return cell;
}



@end
