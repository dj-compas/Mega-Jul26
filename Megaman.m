//
//  Megaman.m
//  Mega
//
//  Created by Michael Compas on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Megaman.h"
#import "MainView.h"

@implementation Megaman

- (id)initWithFrame:(CGRect)frame parentView:(UIView *)par
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
		parent = par;
		
		rockman = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mega_frame_stand.png"]];
		
		
		//rockman.animationDuration = 0.8;
		
		[self addSubview:rockman];
    }
    return self;
}

-(void)startRun
{
	rockman.animationDuration = 0.8;
	rockman.animationRepeatCount = 0;
	rockman.animationImages = [NSArray arrayWithObjects:
							   [UIImage imageNamed:@"mega_frame_run1.png"],
							   [UIImage imageNamed:@"mega_frame_run2.png"],
							   [UIImage imageNamed:@"mega_frame_run3.png"],
							   [UIImage imageNamed:@"mega_frame_run2.png"],
							   nil];
	
	[rockman startAnimating];
}

-(void)stopRun
{
	[rockman stopAnimating];
	rockman.image = [UIImage imageNamed:@"mega_frame_stand"];
}

-(void)startJump
{
	[self stopRun];
	rockman.image = [UIImage imageNamed:@"mega_frame_jump"];
}

-(void)stopJump
{
	rockman.image = [UIImage imageNamed:@"mega_frame_stand"];
}

-(void)startHit
{
	[rockman stopAnimating];
	
	NSTimeInterval duration = .7;
	rockman.animationDuration = duration;
	rockman.animationRepeatCount = 1;
	rockman.animationImages = [NSArray arrayWithObjects:
							   [UIImage imageNamed:@"mega_frame_hit.png"],
							   [UIImage imageNamed:@"mega_frame_flash.png"],
							   [UIImage imageNamed:@"mega_frame_hit.png"],
							   [UIImage imageNamed:@"mega_frame_flash1.png"],
							   [UIImage imageNamed:@"mega_frame_hit.png"],
							   [UIImage imageNamed:@"mega_frame_flash2.png"],
							   [UIImage imageNamed:@"mega_frame_hit.png"],
							   [UIImage imageNamed:@"mega_frame_flash3.png"],
							   [UIImage imageNamed:@"mega_frame_hit.png"],
							   nil];
	
	[rockman startAnimating];
	
	[parent performSelector:@selector(checkRunning) withObject:parent afterDelay:duration];
}

//-(void)afterHit
//{
//	
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
	
}
*/

@end
