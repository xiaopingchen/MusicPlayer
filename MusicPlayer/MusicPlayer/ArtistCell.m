//
//  ArtistCell.m
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/21/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import "ArtistCell.h"
#import "FXImageView.h"

@implementation ArtistCell
@synthesize coverImage;
@synthesize albumsLabel;
@synthesize artistNameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
