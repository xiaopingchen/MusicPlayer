//
//  SideBarViewController.m
//  MusicPlayer
//
//  Created by Jiang Xiao on 9/1/12.
//  Copyright (c) 2012 Jiang Xiao. All rights reserved.
//

#import "SidebarViewController.h"

#define kTableRows 4
#define kTableSections 1
#define kTableRowHeight 88

@interface SidebarViewController ()

@end

@implementation SidebarViewController

@synthesize sidebarDelegate = _sidebarDelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
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
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	}
	
    // Configure the cell...
	switch (indexPath.row) {
		case 0:
			cell.textLabel.text = @"Player";
			break;
		case 1:
			cell.textLabel.text = @"Songs";
			break;
		case 2:
			cell.textLabel.text = @"Albums";
			break;
		case 3:
			cell.textLabel.text = @"Artists";
			break;
			
		default:
			break;
	}
    
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
