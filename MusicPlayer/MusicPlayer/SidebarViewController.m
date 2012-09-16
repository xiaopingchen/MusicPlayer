//
//  SideBarViewController.m
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/1/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import "SidebarViewController.h"

#define kTableRows 6
#define kTableSections 1
#define kTableRowHeight 80
#define kSidebarWidth 80

@interface SidebarViewController ()

@end

@implementation SidebarViewController

@synthesize sidebarDelegate = _sidebarDelegate;

+ (SidebarViewController *)sharedInstance
{
	static SidebarViewController *sidebarViewController = nil;
    @synchronized(self) {
        if (sidebarViewController == nil)
            sidebarViewController = [[self alloc] initWithStyle:UITableViewStylePlain];
    }
	return sidebarViewController;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
		CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
		CGRect expectedFrame = [self.view convertRect:appFrame fromView:nil];
		self.view.frame = CGRectMake(0, expectedFrame.origin.y, kSidebarWidth, expectedFrame.size.height);
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.tableView.scrollEnabled = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
	// amount to select current tab bar item
	if ([(UIViewController *)self.sidebarDelegate respondsToSelector:@selector(lastSelectedIndexPathForSidebarViewController:)]) {
		NSIndexPath *indexPath = [self.sidebarDelegate lastSelectedIndexPathForSidebarViewController:self];
		[self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kTableRowHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kTableSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kTableRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SidebarCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
    // Configure the cell...

	NSString *imageName = [NSString stringWithFormat:@"sidebar_%d.png", indexPath.row + 1];
	[cell.imageView setImage:[UIImage imageNamed:imageName]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (self.sidebarDelegate) {
		[self.sidebarDelegate sidebarViewController:self didSelectViewControllerAtIndexPath:indexPath];
	}
}

@end
