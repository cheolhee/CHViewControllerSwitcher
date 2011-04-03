//
//  CHViewControllerSwitcher.h
//  CHViewControllerSwitcher
//
//  Copyright 2011 cheolhee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHViewControllerSwitcher : UIViewController {

    NSMutableArray *_viewControllers;

    UIViewController *_selectedViewController;
    
    UIView *_layoutView;
        
    NSInteger _oldIndex;
    NSUInteger _selectedIndex;
    
    BOOL _useCustomFrameSize;
    CGRect _frameForPortrait;
    CGRect _frameForLandscape;
    
}

@property (nonatomic, retain) IBOutlet UIView *layoutView;
@property (nonatomic, assign) BOOL useCustomFrameSize;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign) UIViewController *selectedViewController;
@property (nonatomic, assign) CGRect frameForPortrait;
@property (nonatomic, assign) CGRect frameForLandscape;
@property (nonatomic, copy) NSArray *viewControllers;




@end

