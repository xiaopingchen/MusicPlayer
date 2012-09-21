//
//  ArtistCell.h
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/21/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXImageView;

@interface ArtistCell : UITableViewCell
@property (weak, nonatomic) IBOutlet FXImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *albumsLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;

@end
