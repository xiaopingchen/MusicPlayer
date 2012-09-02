//
//  PlayerViewViewController.m
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/1/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import "PlayerViewViewController.h"
#import "SidebarViewController.h"
#import "UINavigationItem+JTRevealSidebarV2.h"
#import "UIViewController+JTRevealSidebarV2.h"

#define kSidebarWidth 100

@interface PlayerViewViewController () <SidebarViewControllerDelegate>

@end

@implementation PlayerViewViewController

@synthesize leftSelectedIndexPath = _leftSelectedIndexPath;
@synthesize leftSidebarViewController = _leftSidebarViewController;

- (SidebarViewController *)leftSidebarViewController
{
	if (!_leftSidebarViewController) {
		_leftSidebarViewController = [[SidebarViewController alloc] initWithStyle:UITableViewStylePlain];
		CGRect appFrame = self.navigationController.applicationViewFrame;
		_leftSidebarViewController.view.frame = CGRectMake(0, appFrame.origin.y, kSidebarWidth, appFrame.size.height);
		_leftSidebarViewController.sidebarDelegate = self;
	}
	return _leftSidebarViewController;
}

#pragma mark - Life Cycle

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
	// Do any additional setup after loading the view.
	
	self.tabBarController.tabBar.hidden = YES;
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(revealLeftSidebar:)];
	self.navigationItem.revealSidebarDelegate = self;
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - Mark Action

- (void)revealLeftSidebar:(id)sender {
    [self.navigationController toggleRevealState:JTRevealedStateLeft];
}

#pragma mark - JTRevealSidebarDelegate

- (UIView *)viewForLeftSidebar
{
	return self.leftSidebarViewController.tableView;
}

// Optional delegate methods for additional configuration after reveal state changed
- (void)didChangeRevealedStateForViewController:(UIViewController *)viewController
{
	
}

#pragma mark SidebarViewControllerDelegate

- (void)sidebarViewController:(SidebarViewController *)sidebarViewController didSelectViewControllerAtIndexPath:(NSIndexPath *)indexPath
{
	[self.navigationController setRevealedState:JTRevealedStateNo];
	self.tabBarController.selectedIndex = indexPath.row;
}

- (NSIndexPath *)lastSelectedIndexPathForSidebarViewController:(SidebarViewController *)sidebarViewController {
    return self.leftSelectedIndexPath;
}


@end
