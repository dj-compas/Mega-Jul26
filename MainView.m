//
//  MainView.m
//  Mega
//
//  Created by Michael Compas on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainView.h"
#import "Megaman.h"
#import "ViewController.h"
#import "Enemy.h"

@implementation MainView

- (id)initWithFrame:(CGRect)frame viewController:(UIViewController *) c
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
		controller = c;
		floorSpeed = 3;
		running = NO;
		jumpHeight = 150;
		enemyAdded = NO;
		hitDetected = NO;
		
		// gesture recognizers
		swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
		swipe.direction = UISwipeGestureRecognizerDirectionRight;
		[self addGestureRecognizer:swipe];
		//
		swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
		swipe.direction = UISwipeGestureRecognizerDirectionLeft;
		[self addGestureRecognizer:swipe];
		//
		swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
		swipe.direction = UISwipeGestureRecognizerDirectionUp;
		[self addGestureRecognizer:swipe];
		//============================================================
		
		// make floor view
		stageFloor = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stage_floor_tile.png"]];
		floor_x = 0;
		floor_y = 320 - 50;
		stageFloor.transform = CGAffineTransformMakeTranslation(0, floor_y);
		
		// make background
		stageBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stage_background_tile.png"]];
		bg_x = 0;
		bg_y = floor_y - stageBg.frame.size.height;
		stageBg.transform = CGAffineTransformMakeTranslation(0, bg_y);
		
		// make megaman view
		CGRect frame = CGRectMake(0, 0, 78, 100);
		mega = [[Megaman alloc] initWithFrame:frame parentView:self];
		mega.transform = CGAffineTransformMakeTranslation(20, floor_y - mega.frame.size.height);
		
		// add subviews
		[self addSubview:stageBg];
		[self addSubview:stageFloor];
		[self addSubview:mega];
		
		
		// misc
		//[mega startRun];
		//NSLog(@"floor frame: %@", NSStringFromCGRect(stageFloor.frame));
		//NSLog(@"self frame: %@", NSStringFromCGRect(self.frame));
    }
    return self;
}

-(void)moveFloor
{
	// move floor
	floor_x -= floorSpeed;
	stageFloor.transform = CGAffineTransformMakeTranslation(floor_x, floor_y);
	
	if (stageFloor.frame.origin.x <= -160)
	{
		floor_x = ABS(stageFloor.frame.origin.x) - 160;
	}
	
	// move background
	bg_x -= floorSpeed - 1;
	stageBg.transform = CGAffineTransformMakeTranslation(bg_x, bg_y);
	
	if (stageBg.frame.origin.x <= -501)
	{
		bg_x = 0;
	}
	
	// add enemy
	if (!enemyAdded)
	{
		// generate random number as occurence and test if criteria is met
		NSUInteger freq = arc4random_uniform(100);
		
		if (freq <=2) // moveFloor is called with CADisplayLink, which is called 60x/sec, so the test value is kept low so that the enemy isn't generated too often
		{
			enemyAdded = YES;
			[self addEnemy];
		}
	}
	else if (enemyAdded)
	{
		// move the enemy with the floor
		enemy_x -= floorSpeed;
		enemy.transform = CGAffineTransformMakeTranslation(enemy_x, enemy_y);
		
		// check if enemy is off-screen
		if (enemy_x <= -1 * enemy.frame.size.width)
		{
			[enemy removeFromSuperview];
			enemyAdded = NO;
			hitDetected = NO;
		}
	}
	
	// if megaman hits the enemy
	if (!hitDetected && CGRectIntersectsRect(mega.frame, enemy.frame))
	{
		// (resort to stricter testing)
		// during collision detection, check if the collision hits the front half of megaman
		if (enemy.frame.origin.x >= mega.frame.origin.x + mega.frame.size.width/2)
		{
			hitDetected = YES;
			[mega startHit];
		}
		
	}
	
	//NSLog(@"floor frame x: %f", stageFloor.frame.origin.x);
}

-(void)addEnemy
{
	// make enemy Met
	CGRect enemyFrame = CGRectMake(0, 0, 60, 60);
	enemy = [[Enemy alloc] initWithFrame:enemyFrame parentView:self];
	enemy_x = 500;
	enemy_y = floor_y - enemy.frame.size.height;
	enemy.transform = CGAffineTransformMakeTranslation(enemy_x, enemy_y);
	[self insertSubview:enemy belowSubview:mega];
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	[mega startRun];
//	[controller performSelector:@selector(moveStage)];
//}
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	[mega startHit];
//	[enemy startWalk];
//	//[controller performSelector:@selector(stopStage)];
//}

-(void)swiped:(UISwipeGestureRecognizer *) s
{
	//NSLog(@"direction: %@", s);
	//NSLog(mega.wasHit ? @"hit!" : @"not hit");
	if (!running && s.direction == UISwipeGestureRecognizerDirectionRight)
	{
		[mega startRun];
		[controller performSelector:@selector(moveStage)];
		running = YES;
		enemy.autoAnimate = YES;
	}
	else if (running && s.direction == UISwipeGestureRecognizerDirectionLeft)
	{
		[mega stopRun];
		[controller performSelector:@selector(stopStage)];
		running = NO;
		enemy.autoAnimate = NO;
	}
	
	if (s.direction == UISwipeGestureRecognizerDirectionUp && !mega.wasHit)
	{
		[mega startJump];
		[self animateJumpUp];
	}
}

-(void)animateJumpUp
{
	floorSpeed = 5; // increase floor speed temporarily to help clear enemy during jump
	[UIView animateWithDuration:.33
						  delay:0
						options:UIViewAnimationOptionCurveEaseOut
					 animations:^{
						 mega.transform = CGAffineTransformMakeTranslation(mega.frame.origin.x, mega.frame.origin.y - jumpHeight);
					 }
					 completion:^(BOOL finished){
						 if (finished)
						 {
							 [self animateJumpDown];
						 }
					 }
	 ];
}

-(void)animateJumpDown
{
	[UIView animateWithDuration:.26
						  delay:.05
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 mega.transform = CGAffineTransformMakeTranslation(mega.frame.origin.x, mega.frame.origin.y + jumpHeight);
					 }
					 completion:^(BOOL finished){
						 if (finished)
						 {
							 floorSpeed = 3;
							 
							 if(!mega.wasHit)
							 [self checkRunning];
						 }
					 }
	 ];
}

-(void)checkRunning
{
	
	if (!running)
	{
		[mega stopJump];
	}
	else if (running) {
		[mega startRun];
		mega.wasHit = NO;
	}
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
