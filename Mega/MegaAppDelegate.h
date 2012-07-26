//
//  MegaAppDelegate.h
//  Mega
//
//  Created by Michael Compas on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;

@interface MegaAppDelegate : UIResponder <UIApplicationDelegate>
{
	ViewController *controller;
}

@property (strong, nonatomic) UIWindow *window;

@end
