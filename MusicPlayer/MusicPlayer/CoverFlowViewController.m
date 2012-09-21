
#import "CoverFlowViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"

@interface CoverFlowViewController ()

@property (nonatomic, strong) NSArray *albums;
@property (nonatomic, strong) UIButton *sideBarButton;

@end


@implementation CoverFlowViewController

@synthesize carousel = _carousel;
@synthesize albums = _albums;
@synthesize sideBarButton = _sideBarButton;

- (NSArray *)albums
{
	if (!_albums) {
		MPMediaQuery *query = [MPMediaQuery albumsQuery];
		_albums = query.collections;
	}
	return _albums;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.tabBarController.tabBar.hidden = YES;
	self.navigationController.navigationBarHidden = YES;
	
	// configure side bar button
	self.sideBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.sideBarButton setBackgroundImage:[UIImage imageNamed:@"sidebar_button.png"] forState:UIControlStateNormal];
	[self.sideBarButton addTarget:self action:@selector(revealLeftSidebar:) forControlEvents:UIControlEventTouchUpInside];
	self.sideBarButton.frame = CGRectMake(20, 20, 16, 16);
	[self.view addSubview:self.sideBarButton];
    
	_carousel.type = iCarouselTypeCylinder;
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [self.albums count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil){
        FXImageView *imageView = [[FXImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.asynchronous = YES;
        imageView.reflectionScale = 0.5f;
        imageView.reflectionAlpha = 0.25f;
        imageView.reflectionGap = 10.0f;
        imageView.shadowOffset = CGSizeMake(0.0f, 2.0f);
		imageView.cornerRadius = 10;
        imageView.shadowBlur = 5.0f;
        view = imageView;
	}
    
    //load image
	MPMediaItemCollection *album = [self.albums objectAtIndex:index];
	MPMediaItem *song = [album.items objectAtIndex:0];
	MPMediaItemArtwork *artWork = [song valueForProperty:MPMediaItemPropertyArtwork];
	
    [(FXImageView *)view setImage:[artWork imageWithSize:CGSizeMake(200, 200)]];

    return view;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)revealLeftSidebar:(id)sender {
	AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate revealLeftSidebar:sender];
	
}


@end
