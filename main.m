//
//  main.m
//  CHViewControllerSwitcher
//

//  Copyright 2011 cheolhee. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
//    instrumentObjcMessageSends(YES);
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
