//
//  Enemy.m
//  Mega
//
//  Created by Michael Compas on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"
#import "MainView.h"

@implementation Enemy
@synthesize autoAnimate;

- (id)initWithFrame:(CGRect)frame parentView:(UIView *)par
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
		parent = par;
		autoAnimate = YES;
		
		walkRepeat = arc4random_uniform(7);
		randomDelayBeforeWalk = arc4random_uniform(3);
		
		walkRepeatMinimum = 3; // 
		if (walkRepeat < walkRepeatMinimum)
		{
			walkRepeat = walkRepeatMinimum;
		}
		
		
		
		met = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"enemy1.png"]];
		
		[self addSubview:met];
		
		[self decideWalk];
    }
    return self;
}

-(void)decideWalk
{
	//NSLog(self.autoAnimate ? @"autoAnimate? YES" : @"autoAnimate? NO");
	if (self.autoAnimate)
	{
		NSTimeInterval seconds = randomDelayBeforeWalk;
		[self performSelector:@selector(startWalk) withObject:self afterDelay:seconds];
	}
}

-(void)startWalk
{
	NSTimeInterval duration = 0.4;
	met.animationDuration = duration;
	met.animationRepeatCount = 1;
	met.animationImages = [NSArray arrayWithObjects:
						   [UIImage imageNamed:@"enemy2.png"],
						   /*[UIImage imageNamed:@"enemy3.png"],*/
						   nil];
	[met startAnimating];
	
	[self performSelector:@selector(walkCycle) withObject:self afterDelay:duration];
}

-(void)walkCycle
{
	[met stopAnimating];
	NSTimeInterval walkCycleDuration = 0.4;
	met.animationDuration = walkCycleDuration;
	met.animationRepeatCount = walkRepeat;
	met.animationImages = [NSArray arrayWithObjects:
						   [UIImage imageNamed:@"enemy3.png"],
						   [UIImage imageNamed:@"enemy4.png"],
						   nil];
	[met startAnimating];
	
	[self performSelector:@selector(stopWalk) withObject:self afterDelay:walkRepeat * walkCycleDuration];
}

-(void)stopWalk
{
	NSTimeInterval duration = 0.8;
	met.animationDuration = duration;
	met.animationRepeatCount = 1;
	met.animationImages = [NSArray arrayWithObjects:
						   [UIImage imageNamed:@"enemy2.png"],
						   [UIImage imageNamed:@"enemy1.png"],
						   nil];
	[met startAnimating];
	
	[self performSelector:@selector(decideWalk) withObject:self afterDelay:0.8];
}

-(void)setAutoAnimate:(BOOL)a
{
	autoAnimate = a;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
