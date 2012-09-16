//
//  AlbumCell.h
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/16/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import <SEMasonryView/SEMasonryCell.h>

@interface AlbumCell : SEMasonryCell

- (void) updateCellInfo:(NSDictionary *)data;

@end
