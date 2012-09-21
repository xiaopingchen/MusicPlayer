//
//  ArtistsViewController.m
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/2/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import "ArtistsViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "FXImageView.h"
#import "AppDelegate.h"
#import "ArtistCell.h"

@interface ArtistsViewController ()

@property (nonatomic, strong) UIButton *sideBarButton;
@end

@implementation ArtistsViewController

@synthesize artists = _artists;
@synthesize sideBarButton = _sideBarButton;

#pragma mark - Reveal Sidebar

- (void)revealLeftSidebar:(id)sender {
	AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate revealLeftSidebar:sender];
}

#pragma mark - Life Cycle

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
		
	MPMediaQuery *query = [MPMediaQuery artistsQuery];
	self.artists = query.collections;
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
	headerView.backgroundColor = [UIColor colorWithRed:157/255.0 green:77/255.0 blue:104/255.0 alpha:1.0];
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
	label.text = @"Artists";
	label.font = [UIFont fontWithName:@"Reyna" size:30];
	label.textAlignment = UITextAlignmentCenter;
	label.textColor = [UIColor whiteColor];
	label.backgroundColor = [UIColor clearColor];
	label.center = CGPointMake(headerView.bounds.size.width / 2, headerView.bounds.size.height / 2);
	[headerView addSubview:label];
	
	// configure side bar button
	if (!self.sideBarButton) {
		self.sideBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
//		[self.sideBarButton setBackgroundImage:[UIImage imageNamed:@"sidebar_button.png"] forState:UIControlStateNormal];
		[self.sideBarButton addTarget:self action:@selector(revealLeftSidebar:) forControlEvents:UIControlEventTouchUpInside];
		self.sideBarButton.frame = CGRectMake(10, 10, 30, 30);
	}
	[headerView addSubview:self.sideBarButton];
	
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_sidebar.png"]];
	imageView.frame = CGRectMake(20, 20, 16, 16);
	[headerView addSubview:imageView];

	return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.artists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ArtistCell";
    ArtistCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	cell.artistNameLabel.adjustsFontSizeToFitWidth = YES;
	cell.albumsLabel.adjustsFontSizeToFitWidth = YES;
    cell.artistNameLabel.font = [UIFont fontWithName:@"Reyna" size:35];
    cell.albumsLabel.font = [UIFont fontWithName:@"Reyna" size:15];
	
	// set artwork frame and labels
	if (indexPath.row % 2 == 1) {
		cell.coverImage.frame = CGRectMake(250, 10, 60, 60);
		cell.artistNameLabel.frame = CGRectMake(20, 10, 222, 49);
		cell.albumsLabel.frame = CGRectMake(20, 45, 222, 30);
		cell.artistNameLabel.textAlignment = UITextAlignmentRight;
		cell.albumsLabel.textAlignment = UITextAlignmentRight;
	} else {
		cell.coverImage.frame = CGRectMake(10, 10, 60, 60);
		cell.artistNameLabel.frame = CGRectMake(78, 10, 222, 49);
		cell.albumsLabel.frame = CGRectMake(78, 45, 222, 30);
		cell.artistNameLabel.textAlignment = UITextAlignmentLeft;
		cell.albumsLabel.textAlignment = UITextAlignmentLeft;
	}
		
    // Set Artist Name
	MPMediaItemCollection *artist = [self.artists objectAtIndex:indexPath.row];
	MPMediaItem *song = artist.items.lastObject;
	cell.artistNameLabel.text = [[song valueForProperty:MPMediaItemPropertyArtist] uppercaseString];
	
	// Set albums number
	MPMediaPropertyPredicate *artistNamePredicate = [MPMediaPropertyPredicate predicateWithValue:[song valueForProperty:MPMediaItemPropertyArtist]  forProperty:MPMediaItemPropertyArtist];
	MPMediaQuery *albumsForSinger = [MPMediaQuery albumsQuery];
	[albumsForSinger addFilterPredicate:artistNamePredicate];
	cell.albumsLabel.text = [NSString stringWithFormat:@"Album %d",albumsForSinger.collections.count];
	
	// Setup Artwork
	MPMediaItemArtwork *artWork = [song valueForProperty:MPMediaItemPropertyArtwork];
	UIImage *cover = [artWork imageWithSize:CGSizeMake(60, 60)];
	cell.coverImage.cornerRadius = cell.coverImage.frame.size.width / 2;
	cell.coverImage.image = cover;

    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

@end
