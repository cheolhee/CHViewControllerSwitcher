//
//  CHViewControllerSwitcher.m
//  CHViewControllerSwitcher
//
//  Copyright 2011 cheolhee. All rights reserved.
//

#import "CHViewControllerSwitcher.h"


@interface CHViewControllerSwitcher (NEPrivateMethods)

-(void)layoutSubview;
-(void)setSelectedIndex:(NSUInteger)idx force:(BOOL)force;

@end

@implementation CHViewControllerSwitcher

@synthesize useCustomFrameSize = _useCustomFrameSize;
@synthesize selectedIndex = _selectedIndex;
@synthesize selectedViewController = _selectedViewController;
@synthesize layoutView = _layoutView;
@synthesize frameForPortrait = _frameForPortrait;
@synthesize frameForLandscape = _frameForLandscape;
@synthesize viewControllers = _viewControllers;



//*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _useCustomFrameSize = NO;
        _selectedViewController = nil;
        // Custom initialization
    }
    return self;
}

-(void)awakeFromNib {
    _useCustomFrameSize = NO;
    _selectedViewController = nil;
}

-(id)init {
    self = [super init];
    if (self) {
        _useCustomFrameSize = NO;
        _selectedViewController = nil;
    }
    return self;
}

//*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
/*/


-(NSArray*)viewControllers {
    if (!_viewControllers) {
        return nil;
    }
    return [NSArray arrayWithArray:_viewControllers];
}

-(void)setViewControllers:(NSArray *)vcs {
    for (UIViewController *vc in _viewControllers) {
        [vc.view removeFromSuperview];
    }
    [_viewControllers release];
    
    int count = vcs.count;
    _viewControllers = [[NSMutableArray alloc] initWithCapacity:count];
    
    for (UIViewController *vc in vcs) {
        [_viewControllers addObject:vc];
    }
    
    _selectedViewController = nil;
    int idx = _selectedIndex;
    if (idx<0 || idx>=count) {
        idx = 0;
    }
    
    [self setSelectedIndex:idx force:YES];
}


-(void)setSelectedViewController:(UIViewController *)viewController {
    NSUInteger idx = [_viewControllers indexOfObject:viewController];
    if (idx!=NSNotFound) {
        [self setSelectedIndex:idx];
    }
}

-(void)setSelectedIndex:(NSUInteger)idx {
    [self setSelectedIndex:idx force:NO];
}

-(void)setSelectedIndex:(NSUInteger)idx force:(BOOL)force {

    static BOOL animated = NO;
    
    if (!_selectedViewController) {//_selectedIndex==NSNotFound) {
        UIViewController *newVC = [_viewControllers objectAtIndex:idx];
        _selectedIndex = idx;
        _selectedViewController = newVC;
        
        [newVC viewWillAppear:animated];
        [self layoutSubview];
        [newVC viewDidAppear:animated];
    } else
    if (force || idx!=_selectedIndex) {

        UIViewController *oldVC = [_viewControllers objectAtIndex:_selectedIndex];
        UIViewController *newVC = [_viewControllers objectAtIndex:idx];
        _selectedIndex = idx;
        _selectedViewController = newVC;
        
        [oldVC.view removeFromSuperview];
        [oldVC viewWillDisappear:animated];
        [newVC viewWillAppear:animated];
        
        [self layoutSubview];
        
        [oldVC viewDidDisappear:animated];
        [newVC viewDidAppear:animated];
        
    }
    

}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.selectedViewController viewWillAppear:animated];
	[self layoutSubview];
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    [self.selectedViewController viewDidAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self.selectedViewController viewWillDisappear:animated];
}


- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[self.selectedViewController viewDidDisappear:animated];
}

- (void)layoutSubviewForInterfaceOrientation:(UIInterfaceOrientation)orientation {

    UIViewController *vc = self.selectedViewController;
    UIView *v = vc.view;
#ifdef DEBUG    
    NSLog(@"selectedIndex=%d", _selectedIndex);
    NSLog(@"selectedVC=%@", _selectedViewController);
    NSLog(@"v=%@", v);
#endif    
    if (v) {
        if (_useCustomFrameSize) {
            CGRect frame = UIInterfaceOrientationIsPortrait(orientation)
            ? _frameForPortrait : _frameForLandscape;
            self.layoutView.frame = frame;            
        }
        v.frame = self.layoutView.bounds;
        if (!v.superview) {
            [self.layoutView addSubview:v];
        }
//        static BOOL _f = NO;//YES;
//        
//        if (_f) {
//            
//            if ([vc isKindOfClass:[UINavigationController class]]) {
//                UINavigationController *nvc = (UINavigationController*)vc;
//                BOOL f = nvc.navigationBarHidden;
//                nvc.navigationBarHidden = !f;
//                nvc.navigationBarHidden = f;
//            }
//            _f = NO;
//        }
    }
    
}

- (void)layoutSubview {
	[self layoutSubviewForInterfaceOrientation:self.interfaceOrientation];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[self.selectedViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[self.selectedViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];

#ifdef DEBUG
    NSLog(@"%@", self.selectedViewController);
    NSLog(@"%@", self.selectedViewController.view);
#endif
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[self.selectedViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	// Re-tile views.
	[self layoutSubviewForInterfaceOrientation:toInterfaceOrientation];
}


- (void)willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[self.selectedViewController willAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}


- (void)didAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	[self.selectedViewController didAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation];
}


- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration
{
	[self.selectedViewController willAnimateSecondHalfOfRotationFromInterfaceOrientation:fromInterfaceOrientation duration:duration];
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}

- (void)viewDidUnload {
	self.layoutView = nil;
}


- (void)dealloc {
    _selectedViewController = nil;
    [_viewControllers release];
    _viewControllers = nil;
	self.layoutView = nil;

    [super dealloc];
}

@end
