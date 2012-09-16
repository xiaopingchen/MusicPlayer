//
//  PlayerViewViewController.h
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/1/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "FXImageView.h"

@interface PlayerViewController : UIViewController

@property (nonatomic, strong) MPMusicPlayerController *musicPlayer;
@property (weak, nonatomic) IBOutlet FXImageView *artworkImageView;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistAlbum;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;

- (IBAction)volumeChanged:(id)sender;
- (IBAction)nextSong:(id)sender;
- (IBAction)previousSong:(id)sender;
- (IBAction)playPause:(id)sender;

@end
