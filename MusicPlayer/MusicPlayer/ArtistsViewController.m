//
//  ArtistsViewController.m
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/2/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import "ArtistsViewController.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import "FXImageView.h"

@interface ArtistsViewController ()

@end

@implementation ArtistsViewController

@synthesize artists = _artists;

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
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(revealLeftSidebar:)];
	
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

- (void)revealLeftSidebar:(id)sender {
	AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate revealLeftSidebar:sender];
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 110;
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
	
    // Configure the cell...
	MPMediaItemCollection *artist = [self.artists objectAtIndex:indexPath.row];
	MPMediaItem *song = artist.items.lastObject;
	MPMediaItemArtwork *artWork = [song valueForProperty:MPMediaItemPropertyArtwork];
	UIImage *cover = [artWork imageWithSize:CGSizeMake(110, 110)];
	
	UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, 110)];
	container.backgroundColor = [UIColor clearColor];
	FXImageView *coverImage = [[FXImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
	coverImage.image = cover;
	[container addSubview:coverImage];
	[cell addSubview:container];
	
	UILabel *artistName = [[UILabel alloc] initWithFrame:CGRectMake(120, 30, 200, 30)];
	artistName.font = [UIFont boldSystemFontOfSize:16];
	artistName.textColor = [UIColor colorWithRed:92.0/255.0 green:194.0/255.0 blue:209.0/255.0 alpha:1.0];
	artistName.text = [song valueForProperty:MPMediaItemPropertyArtist];
	[cell addSubview:artistName];

	UILabel *albumName = [[UILabel alloc] initWithFrame:CGRectMake(120, 60, 200, 30)];
	albumName.font = [UIFont boldSystemFontOfSize:14];
	albumName.textColor = [UIColor colorWithRed:236.0/255.0 green:130.0/255.0 blue:153.0/255.0 alpha:1.0];
	albumName.text = [song valueForProperty:MPMediaItemPropertyAlbumTitle];
	[cell addSubview:albumName];
	
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
