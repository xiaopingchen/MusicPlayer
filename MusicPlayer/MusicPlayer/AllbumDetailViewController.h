//
//  AllbumDetailViewController.h
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/21/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllbumDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *songs;
@end
