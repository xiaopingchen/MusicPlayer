//
//  CoverFlowViewController.h
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/16/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXImageView.h"
#import "iCarousel.h"

@interface CoverFlowViewController : UIViewController <iCarouselDataSource>

@property (nonatomic, strong) IBOutlet iCarousel *carousel;

@end



