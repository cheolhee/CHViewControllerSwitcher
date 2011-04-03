//
//  AppDelegate.h
//  CHViewControllerSwitcher
//
//  Copyright 2011 cheolhee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHViewControllerSwitcher;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CHViewControllerSwitcher *viewController;
    
    UINavigationController *_nvc;
    UIViewController *_vc1;
    UIViewController *_vc2;

}

@property (nonatomic, retain) IBOutlet UINavigationController *nvc;
@property (nonatomic, retain) IBOutlet UIViewController *vc1;
@property (nonatomic, retain) IBOutlet UIViewController *vc2;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CHViewControllerSwitcher *viewController;


@end

