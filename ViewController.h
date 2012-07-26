//
//  ViewController.h
//  Mega
//
//  Created by Michael Compas on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h> // for CADisplayLink
@class MainView;

@interface ViewController : UIViewController
{
	MainView *mainView;
	CADisplayLink *displayLink;
	NSRunLoop *loop;
}

@end
