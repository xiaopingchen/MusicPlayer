//
//  SongsViewController.m
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/2/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//


#import "SongsViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"
#import "PlayerViewController.h"
#import "SongCell.h"

@interface SongsViewController ()
@property (nonatomic, strong) UIButton *sideBarButton;
@end

@implementation SongsViewController

@synthesize songs = _songs;
@synthesize sideBarButton = _sideBarButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationController.navigationBarHidden = YES;
	self.tabBarController.tabBar.hidden = YES;
	
	self.tableView.backgroundColor = [UIColor colorWithRed:220/255.0 green:128/255.0 blue:96/255.0 alpha:1.0];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		
	// access songs from ipod library
	MPMediaQuery *query = [MPMediaQuery songsQuery];
	self.songs = query.items;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Mark Action

- (void)revealLeftSidebar:(id)sender {
	AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate revealLeftSidebar:sender];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
	headerView.backgroundColor = [UIColor colorWithRed:220/255.0 green:128/255.0 blue:96/255.0 alpha:1.0];

	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
	label.text = @"Songs";
	label.font = [UIFont fontWithName:@"Reyna" size:30];
	label.textAlignment = UITextAlignmentCenter;
	label.textColor = [UIColor whiteColor];
	label.backgroundColor = [UIColor clearColor];
	label.center = CGPointMake(headerView.bounds.size.width / 2, headerView.bounds.size.height / 2);
	[headerView addSubview:label];
	
	// configure side bar button
	if (!self.sideBarButton) {
		self.sideBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[self.sideBarButton addTarget:self action:@selector(revealLeftSidebar:) forControlEvents:UIControlEventTouchUpInside];
		self.sideBarButton.frame = CGRectMake(10, 10, 30, 30);
	}
	[headerView addSubview:self.sideBarButton];
	
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_sidebar.png"]];
	imageView.frame = CGRectMake(20, 20, 16, 16);
	[headerView addSubview:imageView];
	
	return headerView;
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
    static NSString *CellIdentifier = @"SongCell";
    SongCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.nameLabel.textColor = [UIColor whiteColor];
	cell.artistLabel.textColor = [UIColor whiteColor];
	cell.nameLabel.font = [UIFont fontWithName:@"Reyna" size:30];
	cell.artistLabel.font = [UIFont fontWithName:@"Reyna" size:20];
	cell.nameLabel.adjustsFontSizeToFitWidth = YES;
	cell.artistLabel.adjustsFontSizeToFitWidth = YES;
    
    // Configure the cell...
	
	MPMediaItem *song = [self.songs objectAtIndex:indexPath.row];
//	MPMediaItemArtwork *artWork = [song valueForProperty: MPMediaItemPropertyArtwork];
//	cell.imageView.image = [artWork imageWithSize:cell.imageView.bounds.size];
    cell.nameLabel.text = [song valueForProperty:MPMediaItemPropertyTitle];
	cell.artistLabel.text = [song valueForProperty:MPMediaItemPropertyAlbumArtist];
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
