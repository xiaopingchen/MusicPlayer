//
//  PlayerViewViewController.m
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/1/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import "PlayerViewController.h"
#import "SidebarViewController.h"
#import "AppDelegate.h"
#import "UINavigationItem+JTRevealSidebarV2.h"
#import "UIViewController+JTRevealSidebarV2.h"

#define kSidebarWidth 130

@interface PlayerViewController ()
- (void)registerMediaPlayerNotifications;
- (void)removeMediaPlayerNotifications;
@end

@implementation PlayerViewController

@synthesize musicPlayer = _musicPlayer;
@synthesize artworkImageView = _artworkImageView;
@synthesize songLabel = _songLabel;
@synthesize albumLabel = _albumLabel;
@synthesize artistAlbum = _artistAlbum;
@synthesize playPauseButton = _playPauseButton;
@synthesize volumeSlider = _volumeSlider;


// change playPause button based on player state
- (void)togglePlayPause
{
	if (self.musicPlayer.playbackState == MPMusicPlaybackStatePlaying) {
		[self.playPauseButton setImage:[UIImage imageNamed:@"pauseButton.png"] forState:UIControlStateNormal];
	} else if (self.musicPlayer.playbackState == MPMusicPlaybackStatePaused) {
		[self.playPauseButton setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
	}
}

#pragma mark - Media Player Notifications

- (void)registerMediaPlayerNotifications
{
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter addObserver: self
						   selector: @selector (handle_NowPlayingItemChanged:)
							   name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification
							 object: self.musicPlayer];
	
	[notificationCenter addObserver: self
						   selector: @selector (handle_PlaybackStateChanged:)
							   name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
							 object: self.musicPlayer];
	
	[notificationCenter addObserver: self
						   selector: @selector (handle_VolumeChanged:)
							   name: MPMusicPlayerControllerVolumeDidChangeNotification
							 object: self.musicPlayer];
	
	[self.musicPlayer beginGeneratingPlaybackNotifications];
}

- (void)removeMediaPlayerNotifications
{
	[[NSNotificationCenter defaultCenter] removeObserver: self
													name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification
												  object: self.musicPlayer];
	
	[[NSNotificationCenter defaultCenter] removeObserver: self
													name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
												  object: self.musicPlayer];
	
	[[NSNotificationCenter defaultCenter] removeObserver: self
													name: MPMusicPlayerControllerVolumeDidChangeNotification
												  object: self.musicPlayer];
	
	[self.musicPlayer endGeneratingPlaybackNotifications];
}

- (void)handle_NowPlayingItemChanged:(id)notification
{
    MPMediaItem *currentItem = [self.musicPlayer nowPlayingItem];
    UIImage *artworkImage = [UIImage imageNamed:@"noArtworkImage.png"];
    MPMediaItemArtwork *artwork = [currentItem valueForProperty: MPMediaItemPropertyArtwork];
	
    if (artwork) {
        artworkImage = [artwork imageWithSize: CGSizeMake (200, 200)];
    }
	
    [self.artworkImageView setImage:artworkImage];
	
    NSString *titleString = [currentItem valueForProperty:MPMediaItemPropertyTitle];
    if (titleString) {
		self.songLabel.text = titleString;
    } else {
        self.songLabel.text = @"Unknown title";
    }
	
    NSString *artistString = [currentItem valueForProperty:MPMediaItemPropertyArtist];
    if (artistString) {
        self.artistAlbum.text = artistString;
    } else {
        self.artistAlbum.text = @"Unknown artist";
    }
	
    NSString *albumString = [currentItem valueForProperty:MPMediaItemPropertyAlbumTitle];
    if (albumString) {
        self.albumLabel.text = albumString;
    } else {
        self.albumLabel.text = @"Unknown album";
    }
}

- (void)handle_PlaybackStateChanged:(id)notification
{
    MPMusicPlaybackState playbackState = [self.musicPlayer playbackState];
	
    if (playbackState == MPMusicPlaybackStatePaused) {
        [self.playPauseButton setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
		
    } else if (playbackState == MPMusicPlaybackStatePlaying) {
        [self.playPauseButton setImage:[UIImage imageNamed:@"pauseButton.png"] forState:UIControlStateNormal];
		
    } else if (playbackState == MPMusicPlaybackStateStopped) {
		
        [self.playPauseButton setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
        [self.musicPlayer stop];
    }
}

- (void)handle_VolumeChanged:(id)notification
{
	self.volumeSlider.value = self.musicPlayer.volume;
}

#pragma mark - Life Cycle

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
		
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(revealLeftSidebar:)];
//	self.navigationItem.revealSidebarDelegate = self;
	
	// setup music player
	self.musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
	[self.musicPlayer setQueueWithQuery:[MPMediaQuery songsQuery]];
	self.volumeSlider.value = self.musicPlayer.volume;
	[self togglePlayPause];
	[self registerMediaPlayerNotifications];
}

- (void)viewDidUnload
{
	[self setArtworkImageView:nil];
	[self setSongLabel:nil];
	[self setAlbumLabel:nil];
	[self setArtistAlbum:nil];
	[self setPlayPauseButton:nil];
	[self setVolumeSlider:nil];
	[self removeMediaPlayerNotifications];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - Mark Action

- (void)revealLeftSidebar:(id)sender {
	AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate revealLeftSidebar:sender];
}

#pragma mark - Control Actions

- (IBAction)volumeChanged:(id)sender {
	self.musicPlayer.volume = self.volumeSlider.value;
}

- (IBAction)nextSong:(id)sender {
	[self.musicPlayer skipToNextItem];
}

- (IBAction)previousSong:(id)sender {
	[self.musicPlayer skipToPreviousItem];
}

- (IBAction)playPause:(id)sender {
	if (self.musicPlayer.playbackState == MPMusicPlaybackStatePaused) {
		[self.musicPlayer play];
	} else {
		[self.musicPlayer pause];
	}
}

@end
