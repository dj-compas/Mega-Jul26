//
//  MainView.h
//  Mega
//
//  Created by Michael Compas on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Megaman;
@class Enemy;

@interface MainView : UIView
{
	Megaman *mega;
	UIViewController *controller;
	UIImageView *stageFloor;
	Enemy *enemy;
	CGFloat floor_x;
	CGFloat floor_y;
	int floorSpeed;
	UISwipeGestureRecognizer *swipe;
	BOOL running;
	int jumpHeight;
	BOOL enemyAdded;
	CGFloat enemy_x;
	CGFloat enemy_y;
	BOOL hitDetected;
	UIImageView *stageBg;
	CGFloat bg_x;
	CGFloat bg_y;
}

-(id)initWithFrame:(CGRect)frame viewController:(UIViewController *) c;
-(void)moveFloor;
-(void)checkRunning;

@end
