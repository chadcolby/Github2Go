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
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) NSOperationQueue *downloadQueue;
@property (weak, nonatomic) bmwUsersCell *userCell;
@property (strong, nonatomic) NSDictionary *usersDict;
@property (nonatomic) BOOL textCleared;


@end

@implementation bmwUserSearchViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self) {
        self.textCleared = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.usersSearchBar.delegate = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self setUpColorScheme];
    
    self.searchArray = [[NSArray alloc] init];
    self.usersArray = [[NSMutableArray alloc] init];
    self.downloadQueue = [[NSOperationQueue alloc] init];
    self.usersDict = [[NSDictionary alloc] init];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinished:) name:DOWNLOADING object:nil];
}

- (void)setUpColorScheme
{
    self.darkColor = [UIColor colorWithRed:45/255.f green:45/255.f  blue:61/255.f alpha:1.f];
    self.textColor = [UIColor colorWithRed:243/255.f green:195/255.f  blue:47/255.f alpha:1.f];
    self.collectionView.backgroundColor = self.darkColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.usersSearchBar resignFirstResponder];
    [self searchFromString:self.usersSearchBar.text];
    [self.collectionView reloadData];

}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.collectionView reloadData];
}

- (void)clearSearchView
{
    if (self.collectionView.clearsContextBeforeDrawing) {
        [self.userCell reloadInputViews];
    }
}

#pragma mark - Collection View Data Source/Delegate Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.usersArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    bmwUsers *user = self.usersArray[indexPath.row];
    self.userCell = (bmwUsersCell *)cell;
    
    self.userCell.userName.textColor = self.textColor;
    self.userCell.userName.text = user.userName;
    self.userCell.userName.font = [UIFont fontWithName:@"Prime-Light" size:18.f];
    
    
    if (![self.usersSearchBar.text length] == 0) {
        
    
    
    if (user.profilePicture) {
        _userCell.userImage.image = user.profilePicture;
        
    } else {
        if (!user.pictureIsDownloading) {
            [user downloadProfilePicture];
            _userCell.currentlyDownloading = YES;
            _userCell.backgroundColor = self.darkColor;
            }
        }
    } else {
        [cell reloadInputViews];
    }
    return cell;
    
}

#pragma mark - Download methods

- (void)searchFromString:(NSString *)searchString
{
    NSError *error;
    searchString = [NSString stringWithFormat:@"https://api.github.com/search/users?q=%@", searchString];
    searchString = [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *searchURL = [NSURL URLWithString:searchString];
    NSData *searchData = [NSData dataWithContentsOfURL:searchURL];
    

    NSDictionary *searchDictionary = [NSJSONSerialization JSONObjectWithData:searchData
                                                                     options:NSJSONReadingMutableContainers error:&error];
    self.searchArray = searchDictionary[@"items"];
    [self makeUsersArray:self.searchArray];
    
}

- (void)makeUsersArray:(NSArray *)searchArray
{
    for (NSDictionary *tempDictionary in searchArray)
    {
        bmwUsers *user = [[bmwUsers alloc] init];
        user.userName = tempDictionary[@"login"];
        user.avatarURL = tempDictionary[@"avatar_url"];
        user.downloadQueue = self.downloadQueue;
        [self.usersArray addObject:user];
    }

    [self.collectionView reloadData];
}

- (void)downloadFinished:(NSNotification *)notification
{
    id sender = [[notification userInfo] objectForKey:@"user"];
    
    if ([sender isKindOfClass:[bmwUsers class]]) {

        NSIndexPath *userPath = [NSIndexPath indexPathForItem:[self.usersArray indexOfObject:sender] inSection:0];
        bmwUsersCell *cell = [self.collectionView cellForItemAtIndexPath:userPath];
        cell.currentlyDownloading = NO;
        [self.collectionView reloadItemsAtIndexPaths:@[userPath]];
    } else {
        NSLog(@"We had a problem with the download.");
    }
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushToView"]) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
        self.usersDict = self.searchArray[indexPath.row];
        self.webView = [segue destinationViewController];
        self.webView.htmlString = [self.usersDict objectForKey:@"html_url"];
        
        [self.webView.view addSubview:self.webView.webView];
        [self.webView loadWebView:self.webView.htmlString];
        
    }
}


@end



