//
//  HomeViewController.m
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/19/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
- (IBAction)buttonPressed:(UIButton *)sender;

@end

@implementation HomeViewController

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
	// hide nav bar and tab bar
	self.navigationController.navigationBarHidden = YES;
	self.tabBarController.tabBar.hidden = YES;
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)buttonPressed:(UIButton *)sender {
	
	[self.tabBarController setSelectedIndex:sender.tag];
}

@end
