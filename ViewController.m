//
//  ViewController.m
//  Mega
//
//  Created by Michael Compas on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "MainView.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
	CGRect frame = [UIScreen mainScreen].applicationFrame;
	mainView = [[MainView alloc] initWithFrame:frame viewController:self];
	self.view = mainView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	displayLink = [CADisplayLink displayLinkWithTarget: self.view
											  selector: @selector(moveFloor)
				   ];
	
	//Call move: every time the display is refreshed.
	displayLink.frameInterval = 1;
	loop = [NSRunLoop currentRunLoop];
	
	//[self moveStage];
	
}

-(void)moveStage
{
	[displayLink addToRunLoop: loop forMode: NSDefaultRunLoopMode];
}

-(void)stopStage
{
	[displayLink removeFromRunLoop:loop forMode:NSDefaultRunLoopMode];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

@end
