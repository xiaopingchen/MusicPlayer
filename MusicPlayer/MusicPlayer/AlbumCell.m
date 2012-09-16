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
}


@end
