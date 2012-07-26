//
//  Megaman.h
//  Mega
//
//  Created by Michael Compas on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Megaman : UIView
{
	UIImageView *rockman;
	UIView *parent;
	//BOOL wasHit;
}

-(void)startRun;
-(void)stopRun;
-(void)startJump;
-(void)stopJump;
-(void)startHit;

- (id)initWithFrame:(CGRect)frame parentView:(UIView *)parent;

@property (nonatomic, assign) BOOL wasHit;

@end
