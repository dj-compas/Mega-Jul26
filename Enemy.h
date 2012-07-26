//
//  Enemy.h
//  Mega
//
//  Created by Michael Compas on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Enemy : UIView
{
	UIImageView *met;
	int walkRepeat;
	int walkRepeatMinimum;
	int randomDelayBeforeWalk;
	UIView *parent;
	//BOOL autoAnimate;
}

-(void)decideWalk;
-(void)startWalk;
-(void)walkCycle;
-(void)stopWalk;

- (id)initWithFrame:(CGRect)frame parentView:(UIView *)par;

@property (nonatomic, assign) BOOL autoAnimate;


@end
