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
	
	/*
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
	label.text = @"Artists";
	label.font = [UIFont boldSystemFontOfSize:16];
	label.textAlignment = UITextAlignmentCenter;
	label.textColor = [UIColor colorWithRed:92.0/255.0 green:194.0/255.0 blue:209.0/255.0 alpha:1.0];
	label.backgroundColor = [UIColor clearColor];
	label.center = CGPointMake(headerView.bounds.size.width / 2, headerView.bounds.size.height / 2);
	[headerView addSubview:label];
	 */
	
	// configure side bar button
	if (!self.sideBarButton) {
		self.sideBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[self.sideBarButton setBackgroundImage:[UIImage imageNamed:@"sidebar_button.png"] forState:UIControlStateNormal];
		[self.sideBarButton addTarget:self action:@selector(revealLeftSidebar:) forControlEvents:UIControlEventTouchUpInside];
		self.sideBarButton.frame = CGRectMake(20, 20, 16, 16);
	}
	[headerView addSubview:self.sideBarButton];

	return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	cell.textLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
	cell.detailTextLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
	
    // Configure the cell...
	MPMediaItemCollection *artist = [self.artists objectAtIndex:indexPath.row];
	MPMediaItem *song = artist.items.lastObject;
	cell.textLabel.text = [song valueForProperty:MPMediaItemPropertyArtist];
	cell.detailTextLabel.text = [song valueForProperty:MPMediaItemPropertyAlbumTitle];
	
	
	/* Setup Artwork
	MPMediaItemArtwork *artWork = [song valueForProperty:MPMediaItemPropertyArtwork];
	UIImage *cover = [artWork imageWithSize:CGSizeMake(110, 110)];
	
	UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, 110)];
	container.backgroundColor = [UIColor clearColor];
	FXImageView *coverImage = [[FXImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
	coverImage.image = cover;
	[container addSubview:coverImage];
	[cell addSubview:container];
	 */
	
	/*
	UILabel *artistName = [[UILabel alloc] initWithFrame:CGRectMake(120, 30, 200, 30)];
	artistName.backgroundColor =[UIColor clearColor];
	artistName.font = [UIFont boldSystemFontOfSize:16];
	artistName.textColor = [UIColor colorWithRed:92.0/255.0 green:194.0/255.0 blue:209.0/255.0 alpha:1.0];
	artistName.text = [song valueForProperty:MPMediaItemPropertyArtist];
	[cell addSubview:artistName];

	UILabel *albumName = [[UILabel alloc] initWithFrame:CGRectMake(120, 60, 200, 30)];
	albumName.backgroundColor = [UIColor clearColor];
	albumName.font = [UIFont boldSystemFontOfSize:14];
	albumName.textColor = [UIColor colorWithRed:236.0/255.0 green:130.0/255.0 blue:153.0/255.0 alpha:1.0];
	albumName.text = [song valueForProperty:MPMediaItemPropertyAlbumTitle];
	[cell addSubview:albumName];
	 */
	
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	/*
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	UIColor *color = [UIColor colorWithRed:157/250.0 green:77/250.0 blue:104/250.0 alpha:1.0];
	UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 50)];
	aView.backgroundColor = color;
	cell.contentView.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:216/255.0 alpha:1.0];
	[cell.contentView addSubview:aView];
	*/
}

@end
