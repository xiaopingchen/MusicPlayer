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
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
	UIColor *bgColor = nil;
	CGRect buttonFrame;
	
	switch (indexPath.row) {
		case 0:
			buttonFrame = CGRectMake(0, 0, 54, 43);
			bgColor = [UIColor colorWithRed:234.0/255.0 green:77/255.0 blue:104/255.0 alpha:1.0];
			break;
		case 1:
			buttonFrame = CGRectMake(0, 0, 41, 41);
			bgColor = [UIColor colorWithRed:157.0/255.0 green:77/255.0 blue:104/255.0 alpha:1.0];
			break;
		case 2:
			buttonFrame = CGRectMake(0, 0, 50, 49);
			bgColor = [UIColor colorWithRed:157/255.0 green:165/255.0 blue:104/255.0 alpha:1.0];
			break;
		case 3:
			buttonFrame = CGRectMake(0, 0, 53, 47);
			bgColor = [UIColor colorWithRed:220/255.0 green:128/255.0 blue:96/255.0 alpha:1.0];
			break;
		case 4:
			buttonFrame = CGRectMake(0, 0, 62, 37);
			bgColor = [UIColor colorWithRed:250/255.0 green:152/255.0 blue:87/255.0 alpha:1.0];
			break;
		case 5:
			buttonFrame = CGRectMake(0, 0, 53, 45);
			bgColor = [UIColor colorWithRed:240/255.0 green:236/255.0 blue:201/255.0 alpha:1.0];
			break;
			
		default:
			break;
	}

	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = buttonFrame;
	button.center = CGPointMake(40, 40);
	NSString *imageName = [NSString stringWithFormat:@"btn_home_%d.png", indexPath.row + 1];
	[button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
	
	UIView *bgView = [[UIView alloc] init];
	bgView.backgroundColor = bgColor;
	[bgView addSubview:button];
	cell.backgroundView = bgView;
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
