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
	return 60;
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
    if (indexPath.row % 2 == 0) {
    static NSString *CellIdentifier = @"ArtistCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	cell.textLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
	cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Reyna" size:35];
		
    // Configure the cell...
	MPMediaItemCollection *artist = [self.artists objectAtIndex:indexPath.row];
	MPMediaItem *song = artist.items.lastObject;
	cell.textLabel.text = [[song valueForProperty:MPMediaItemPropertyArtist] uppercaseString];
	
	// Setup Artwork
	MPMediaItemArtwork *artWork = [song valueForProperty:MPMediaItemPropertyArtwork];
	UIImage *cover = [artWork imageWithSize:CGSizeMake(60, 60)];
	
	FXImageView *coverImage = [[FXImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
	coverImage.cornerRadius = coverImage.frame.size.width / 2;
//	coverImage.backgroundColor = [UIColor clearColor];
//    coverImage.shadowOffset = CGSizeMake(1.0f, 1.0f);
//    coverImage.shadowBlur = 5.0f;
	coverImage.image = cover;
	[cell addSubview:coverImage];

    return cell;
    }
	
	
    if (indexPath.row % 2 == 1) {
        static NSString *CellIdentifier = @"ArtistCellReverse";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.textLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
        //	cell.textLabel.numberOfLines = 0;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont fontWithName:@"Reyna" size:35];
		
        // Configure the cell...
        MPMediaItemCollection *artist = [self.artists objectAtIndex:indexPath.row];
        MPMediaItem *song = artist.items.lastObject;
		NSString *spaceString = @"                     ";
        cell.textLabel.text = [NSString stringWithFormat:@"%@%@",[[song valueForProperty:MPMediaItemPropertyArtist] uppercaseString], spaceString];
        
        // Setup Artwork
        MPMediaItemArtwork *artWork = [song valueForProperty:MPMediaItemPropertyArtwork];
        UIImage *cover = [artWork imageWithSize:CGSizeMake(60, 60)];
        
        FXImageView *coverImage = [[FXImageView alloc] initWithFrame:CGRectMake(250, 10, 60, 60)];
        coverImage.cornerRadius = coverImage.frame.size.width / 2;
        //	coverImage.backgroundColor = [UIColor clearColor];
        //    coverImage.shadowOffset = CGSizeMake(1.0f, 1.0f);
        //    coverImage.shadowBlur = 5.0f;
        coverImage.image = cover;
        [cell addSubview:coverImage];
        return cell;
        
    }
    return nil;
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
