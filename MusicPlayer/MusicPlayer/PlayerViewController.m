//
//  PlayerViewViewController.m
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/1/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PlayerViewController.h"
#import "SidebarViewController.h"
#import "AppDelegate.h"
#import "UINavigationItem+JTRevealSidebarV2.h"
#import "UIViewController+JTRevealSidebarV2.h"

#define kSidebarWidth 130

@interface PlayerViewController () 

@property (nonatomic, strong) UIButton *sideBarButton;
@property (nonatomic) BOOL isSpinning;

- (void)registerMediaPlayerNotifications;
- (void)removeMediaPlayerNotifications;
@end

@implementation PlayerViewController

@synthesize sideBarButton = _sideBarButton;
@synthesize isSpinning = _isSpinning;
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
	self.isSpinning = NO;
	
	if (self.musicPlayer.playbackState == MPMusicPlaybackStatePlaying) {
		[self startSpinning];
		[self.playPauseButton setImage:[UIImage imageNamed:@"button_play.png"] forState:UIControlStateNormal];
	} else if (self.musicPlayer.playbackState == MPMusicPlaybackStatePaused) {
		[self stopSpinning];
		[self.playPauseButton setImage:[UIImage imageNamed:@"button_play.png"] forState:UIControlStateNormal];
	} else if (self.musicPlayer.playbackState == MPMusicPlaybackStateStopped) {
		[self stopSpinning];
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
		[self stopSpinning];
        [self.playPauseButton setImage:[UIImage imageNamed:@"button_play.png"] forState:UIControlStateNormal];
		
    } else if (playbackState == MPMusicPlaybackStatePlaying) {
		[self startSpinning];
		[self.playPauseButton setImage:[UIImage imageNamed:@"button_play.png"] forState:UIControlStateNormal];
		
    } else if (playbackState == MPMusicPlaybackStateStopped) {
		[self stopSpinning];
        [self.playPauseButton setImage:[UIImage imageNamed:@"button_play.png"] forState:UIControlStateNormal];
        [self.musicPlayer stop];
    }
}

- (void)handle_VolumeChanged:(id)notification
{
	self.volumeSlider.value = self.musicPlayer.volume;
}

#pragma mark - Life Cycle

- (void)setupArtwork
{
	self.artworkImageView.cornerRadius = self.artworkImageView.bounds.size.height / 2;
	self.artworkImageView.reflectionScale = 0.5f;
	self.artworkImageView.reflectionAlpha = 0.25f;
	self.artworkImageView.reflectionGap = 10.0f;
	self.artworkImageView.shadowOffset = CGSizeMake(0.0f, 2.0f);
	self.artworkImageView.shadowBlur = 5.0f;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
	self.navigationController.navigationBarHidden = YES;
		
	// configure side bar button
	self.sideBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.sideBarButton setBackgroundImage:[UIImage imageNamed:@"sidebar_button.png"] forState:UIControlStateNormal];
	[self.sideBarButton addTarget:self action:@selector(revealLeftSidebar:) forControlEvents:UIControlEventTouchUpInside];
	self.sideBarButton.frame = CGRectMake(30, 30, 16, 16);
//	[self.view addSubview:self.sideBarButton];
		
	//
	self.artworkImageView.cornerRadius = self.artworkImageView.bounds.size.height / 2;
	self.artworkImageView.shadowOffset = CGSizeMake(0.0f, 2.0f);
	self.artworkImageView.shadowBlur = 5.0f;

//	[self setupArtwork];
	
	// customize slider
	UIImage *minImage = [[UIImage imageNamed:@"slider_min.png"]
						 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
	UIImage *maxImage = [[UIImage imageNamed:@"slider_max.png"]
						 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 0)];	
	[[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
	[[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
	
	// add gesture to artwork imageview
	UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playPause:)];
	recognizer.numberOfTapsRequired = 1;
	self.artworkImageView.userInteractionEnabled = YES;
	[self.artworkImageView addGestureRecognizer:recognizer];
	
	// setup music player
	self.musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
	[self.musicPlayer setQueueWithQuery:[MPMediaQuery songsQuery]];
	self.volumeSlider.value = self.musicPlayer.volume;
	[self registerMediaPlayerNotifications];
	[self togglePlayPause];

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

#pragma mark - Spinning Animation

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	
}

- (void)stopSpinning
{
	if (self.isSpinning) {
		[self.artworkImageView.layer removeAnimationForKey:@"spinAnimation"];
		self.isSpinning = NO;
	}
}

- (void)startSpinning
{
	if (!self.isSpinning) {
		CABasicAnimation* spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
		spinAnimation.toValue = [NSNumber numberWithFloat:2 * M_PI];
		spinAnimation.duration = 4.0;
		spinAnimation.delegate = self;
		spinAnimation.autoreverses = YES;
		spinAnimation.repeatCount = HUGE_VALF;
		[self.artworkImageView.layer addAnimation:spinAnimation forKey:@"spinAnimation"];
		self.isSpinning = YES;
	}
}

@end
