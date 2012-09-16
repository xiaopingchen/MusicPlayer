//
//  AppDelegate.m
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/2/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import "AppDelegate.h"
#import "JTRevealSidebarV2Delegate.h"
#import "SidebarViewController.h"
#import "UIViewController+JTRevealSidebarV2.h"
#import "UINavigationItem+JTRevealSidebarV2.h"

@interface AppDelegate () <JTRevealSidebarV2Delegate, SidebarViewControllerDelegate>
@property (nonatomic, strong) SidebarViewController  *leftSidebarViewController;
@property (nonatomic, strong) NSIndexPath *leftSelectedIndexPath;
@end


@implementation AppDelegate

@synthesize leftSidebarViewController = _leftSidebarViewController;
@synthesize leftSelectedIndexPath = _leftSelectedIndexPath;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	
	UITabBarController *tbController = (UITabBarController *)self.window.rootViewController;
	for (UINavigationController *navController in tbController.viewControllers) {
		navController.navigationItem.revealSidebarDelegate = self;
	}
	
	self.leftSidebarViewController = [[SidebarViewController alloc] initWithStyle:UITableViewStylePlain];
	self.leftSidebarViewController.sidebarDelegate = self;
	
    return YES;
}

- (void)revealLeftSidebar:(id)sender {
	UITabBarController *tbController = (UITabBarController *)self.window.rootViewController;
    [tbController toggleRevealState:JTRevealedStateLeft];
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
	UITabBarController *tbController = (UITabBarController *)self.window.rootViewController;
	tbController.selectedIndex = indexPath.row;
	[self revealLeftSidebar:nil];
}

- (NSIndexPath *)lastSelectedIndexPathForSidebarViewController:(SidebarViewController *)sidebarViewController {
    return self.leftSelectedIndexPath;
}

	
@end
