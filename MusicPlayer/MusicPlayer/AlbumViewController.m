//
//  AlbumViewController.m
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/16/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import "AlbumViewController.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import <SEMasonryView/SEMasonryCell.h>
#import "AlbumCell.h"

@interface AlbumViewController ()

@property (nonatomic, strong) UIButton *sideBarButton;

@end

@implementation AlbumViewController

@synthesize albums = _albums;
@synthesize sideBarButton = _sideBarButton;

#define kCellX  10
#define kCellY 10
#define kCellWidth  104
#define kCellHeight 104
#define kMansonryViewY      100
#define kMansonryViewHeight 310

#pragma mark - SEMasonryView

- (void)setupSEMasonryView
{
    self.masonryView = [[SEMasonryView alloc] initWithFrame:CGRectMake(0, kMansonryViewY, self.view.bounds.size.width, kMansonryViewHeight)];
    self.masonryView.delegate = self;

	self.masonryView.columnWidth = self.view.bounds.size.width / 3;
    self.masonryView.rowHeight = kMansonryViewHeight / 3;
	
    self.masonryView.loadMoreEnabled = NO;
    self.masonryView.backgroundColor = [UIColor clearColor];
    self.masonryView.horizontalModeEnabled = YES;
    [self.view addSubview:self.masonryView];
}

- (void)setupCell
{
	for (MPMediaItemCollection *album in self.albums) {
				
		SEMasonryCell *cell;
		
		cell = [[[NSBundle mainBundle] loadNibNamed:@"AlbumCell" owner:self options:nil] objectAtIndex: 0];
		cell.horizontalModeEnabled = YES;
		
		// set a tag for your cell, so that you can refer to it when there are interactions like tapping etc..
		cell.tag = [self.albums indexOfObject:album];
		[cell setFrame:CGRectMake(10, 10, kCellWidth, kCellHeight)];
		
		// finally, update the cell's controls with the data coming from the API
		MPMediaItem *song = [album.items objectAtIndex:0];
		MPMediaItemArtwork *artWork = [song valueForProperty:MPMediaItemPropertyArtwork];
		NSDictionary *data = [NSDictionary dictionaryWithObject:[artWork imageWithSize:CGSizeMake(kCellWidth, kCellHeight)] forKey:@"artWork"];
		[cell updateCellInfo:data];
		
		// add it to your MasonryView
		[self.masonryView addCell:cell];
	}
}

- (void) didSelectItemAtIndex:(int) index {
    
    // define some actions when a cell is tapped.
    // in this case an alert with the cell's title is shown
    
	MPMediaItemCollection *album = [self.albums objectAtIndex:index];
	MPMediaItem *song = album.items.lastObject;
	NSLog(@"%@", [song valueForProperty:MPMediaItemPropertyAlbumTitle]);
}


#pragma mark - Reveal Sidebar

- (void)revealLeftSidebar:(id)sender {
	AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate revealLeftSidebar:sender];
}

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
	// Do any additional setup after loading the view.
	
	// hide nav bar and tab bar
	self.navigationController.navigationBarHidden = YES;
	self.tabBarController.tabBar.hidden = YES;
	
	// configure side bar button
	self.sideBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.sideBarButton setBackgroundImage:[UIImage imageNamed:@"sidebar_button.png"] forState:UIControlStateNormal];
	[self.sideBarButton addTarget:self action:@selector(revealLeftSidebar:) forControlEvents:UIControlEventTouchUpInside];
	self.sideBarButton.frame = CGRectMake(20, 20, 16, 16);
	[self.view addSubview:self.sideBarButton];
	
	// right button
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setBackgroundImage:[UIImage imageNamed:@"sidebar_button.png"] forState:UIControlStateNormal];
	button.frame = CGRectMake(284, 20, 16, 16);
	[self.view addSubview:button];
	
	[self setupSEMasonryView];
	
	MPMediaQuery *query = [MPMediaQuery albumsQuery];
	self.albums = query.collections;
	[self setupCell];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
