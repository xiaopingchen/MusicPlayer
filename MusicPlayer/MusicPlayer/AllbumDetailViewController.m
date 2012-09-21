//
//  AllbumDetailViewController.m
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/21/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import "AllbumDetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "PlayerViewController.h"

@interface AllbumDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIButton *sideBarButton;
@end

@implementation AllbumDetailViewController
@synthesize coverImageView = _coverImageView;
@synthesize tableView = _tableView;
@synthesize songs = _songs;
@synthesize sideBarButton = _sideBarButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
//	self.navigationController.navigationBarHidden = YES;
	[self.tabBarController setHidesBottomBarWhenPushed:YES];
	
	// configure side bar button
	self.sideBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.sideBarButton addTarget:self action:@selector(navigationBack:) forControlEvents:UIControlEventTouchUpInside];
	self.sideBarButton.frame = CGRectMake(10, 10, 30, 30);
	[self.view addSubview:self.sideBarButton];
	
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_sidebar.png"]];
	imageView.frame = CGRectMake(20, 20, 16, 16);
	[self.view addSubview:imageView];}

- (void)viewWillAppear:(BOOL)animated
{
	MPMediaItem *song = self.songs.lastObject;
	MPMediaItemArtwork *artWork = [song valueForProperty:MPMediaItemPropertyArtwork];
	self.coverImageView.image = [artWork imageWithSize:self.coverImageView.bounds.size];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setCoverImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)navigationBack:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.songs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
    
    // Configure the cell...
	
	MPMediaItem *song = [self.songs objectAtIndex:indexPath.row];
	//	MPMediaItemArtwork *artWork = [song valueForProperty: MPMediaItemPropertyArtwork];
	//	cell.imageView.image = [artWork imageWithSize:cell.imageView.bounds.size];
    cell.textLabel.text = [song valueForProperty:MPMediaItemPropertyTitle];
	cell.detailTextLabel.text = [song valueForProperty:MPMediaItemPropertyAlbumArtist];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UINavigationController *navController = [self.tabBarController.viewControllers objectAtIndex:1];
	PlayerViewController *playerViewController = (PlayerViewController *)navController.topViewController;
	if (playerViewController.musicPlayer.playbackState == MPMusicPlaybackStatePlaying) {
		[playerViewController.musicPlayer pause];
	}
	playerViewController.musicPlayer.nowPlayingItem = [self.songs objectAtIndex:indexPath.row];
	[playerViewController.musicPlayer play];
	
	self.tabBarController.selectedIndex = 1;
}



@end
