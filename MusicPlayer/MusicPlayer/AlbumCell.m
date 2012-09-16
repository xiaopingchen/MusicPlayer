//
//  AlbumCell.m
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/16/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import "AlbumCell.h"

@implementation AlbumCell

- (void) updateCellInfo:(NSDictionary *)data
{
	imageView.image = [data objectForKey:@"artWork"];
	
	// use FXImageView

	imageView.cornerRadius = imageView.frame.size.width / 2;
	imageView.backgroundColor = [UIColor clearColor];
    imageView.shadowOffset = CGSizeMake(1.0f, 1.0f);
    imageView.shadowBlur = 5.0f;
}


@end
