//
//  ScreenScene2.m
//  TexturePacker-SpriteKit
//
//  Created by GrepRuby on 02/01/15.
//  Copyright (c) 2015 CodeAndWeb. All rights reserved.
//

#import "ScreenScene2.h"
#import "ScreenScene3.h"
#import "Monster.h"
#import "CommanAction.h"
#import "Weapon.h"
#import "GameOverScene.h"
#import "Star.h"

#import "GRModelOfLifeScore.h"
#import "sprites.h"
#import "bgsprites.h"
#import "richter.h"
#import "zombie.h"

#define  yAxisOfSurface 255
#define MaxYTouch 325

@implementation ScreenScene2

#pragma mark - View life cycle

- (id)initWithSize:(CGSize)size {

    if (self = [super initWithSize:size]) {

        scrollVwBackground = [[ScrollingBackground alloc] initWithBackground:nil frame:CGRectMake(0, yAxisOfSurface, size.width*2, 200) speed:0.0];
        [self addChild:scrollVwBackground];
        [self initScene];
    }
    return self;
}

- (void)didMoveToView:(SKView *)view {

    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:recognizer];

    UISwipeGestureRecognizer *recognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    recognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:recognizerDown];

    int y = 300;
    for (int i=0; i<10; i++) {

        int x = [CommanAction addStarsAtXPositionAtRandomPlaceWithWidth:self.size.width];

        Star *satrs = [[Star alloc]initWithPosition:CGPointMake(x, y) withBackgroungTexture:nil];
        [self addChild:satrs];

        if (i%2 == 0) {
            y = y +40;
        }
    }
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)sender {

    NSLog(@"%lu", sender.direction);
    if (sender.state == UIGestureRecognizerStateEnded) {

        CGPoint touchLocation = [sender locationInView:sender.view];
        touchLocation = [self convertPointFromView:touchLocation];
            //   SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];

            //  if ([touchedNode.name isEqualToString:@"Richter"]) {

             if (sender.direction == UISwipeGestureRecognizerDirectionUp) {

                 CGPoint ExactLocation = CGPointMake(touchLocation.x, yAxisOfSurface); //xaxis fixed for surface
                 CGPoint locationDiff = [self compareOneLocation:ExactLocation withSecondLocatio:previousLocation];

                    if (locationDiff.x < 0) {

                        SKAction *actionJump = [CommanAction jumpRichterActionBackWithScreenSize:self.size.width];
                        [richterNode runAction:actionJump];
                        [self moveToMoonWithLocation:CGPointMake(touchLocation.x-320, touchLocation.y)];

                    } else {

                        SKAction *actionJump = [CommanAction jumpRichterActionWithScreenSize:self.size.width];
                        [richterNode runAction:actionJump];
                        [self moveToMoonWithLocation:CGPointMake(touchLocation.x+320, touchLocation.y)];
                    }
                return;
             } else if (sender.direction == UISwipeGestureRecognizerDirectionDown) {

                 NSLog(@"sit");
                 SKAction *actionJump = [CommanAction sitRicher:CGPointMake(0,0)];
                 [richterNode runAction:actionJump];
                 [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(standUpRicher) userInfo:nil repeats:NO];
                     //      }
        }
    }
}

- (void)standUpRicher {

    SKAction *stand = [CommanAction standUpRicher];
    [richterNode runAction:stand];
}

- (void)initScene {

    self.backgroundColor = [UIColor blackColor];

    moon = [[Moon alloc]initWithPosition:CGPointMake(50, yAxisOfSurface) withBackgroungTexture:nil];
    [self addChild:moon]; //moon

    [self addFortBackground]; //add fort background

    background = [[BackGround alloc]initWithPosition:CGPointMake(0,0) withBackgroungTexture:SPRITES_TEX_BGSCENE];
    [background runAction:[SKAction scaleXTo:2.5 y:3 duration:0.0]]; //add  background
    [self addChild:background];

    richterNode  = [[RichterNode alloc]initWithPosition:CGPointMake(60, 170) withBackgroungTexture:nil];
    richterNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20,20)];
    [self addChild:richterNode]; //add  richter

    previousLocation = CGPointMake(0.5,0.5);

    NSString *scene = [[NSUserDefaults standardUserDefaults] valueForKey:@"SecondScene"];

    if ([scene isEqualToString:@"Second"]) {

        richterNode.position = CGPointMake(990, yAxisOfSurface);
        previousLocation = CGPointMake(1010, yAxisOfSurface);
        [richterNode runAction:[SKAction scaleXTo:-1 duration:0.0]];
        moon = [[Moon alloc]initWithPosition:CGPointMake(910, yAxisOfSurface) withBackgroungTexture:nil];
    } else {

        richterNode.position = CGPointMake(50, yAxisOfSurface);
        [richterNode runAction:[SKAction scaleTo:3 duration:0.0]];
    }

        //[self addZoomie];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SecondScene"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    [self addStars];
}

#pragma mark - Add Fort background

- (void)addFortBackground {

    SKSpriteNode *fortNode = [SKSpriteNode spriteNodeWithTexture:SPRITES_FORT];
    fortNode.position = CGPointMake(50, 100);
    [fortNode runAction:[SKAction scaleXTo:2.0 y:2.0 duration:0.0]];
    fortNode.anchorPoint = CGPointMake(0, 0);
    [self addChild:fortNode];
}

- (void)addStars {

        // Emitter
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"stars3" ofType:@"sks"];
    SKEmitterNode *star = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    star.position = CGPointMake(10, self.size.height);
    star.name = @"stars";
    star.zPosition = 0;
    [self addChild:star];
}

#pragma mark - UITouch Event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    NSLog(@"number of touch:%lu", touch.tapCount);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self.scene]; // location

    CGPoint ExactLocation = CGPointMake(location.x, yAxisOfSurface); //xaxis fixed for surface
    CGPoint locationDiff = [self compareOneLocation:ExactLocation withSecondLocatio:previousLocation];

    BOOL isRichterStay = [CommanAction jumpRichterToStayOnPosition:location forGivenLocation:CGPointMake(620, CGRectGetMidY(self.frame)-20)];

    if (locationDiff.x < 0) {

        if (isRichterStay == YES) { //jump up richter on point

            [self moveToMoonWithLocation:location];
            isJumpUp = YES;
            SKAction *actionJump = [CommanAction jumpUPRichterWithLocation:location withBack:YES];
            [richterNode runAction:actionJump];//[SKAction moveTo:location duration:0.0]];
            return;
        }
    } else {

        if (isRichterStay == YES) { //jump up richter on point

            [self moveToMoonWithLocation:location];
            isJumpUp = YES;
            SKAction *actionJump = [CommanAction jumpUPRichterWithLocation:location withBack:NO];
            [richterNode runAction:actionJump];//[SKAction moveTo:location duration:0.0]];
            return;
        }
    }

    if (location.y > MaxYTouch) {
        return;//only walk
    }

    [self moveToMoonWithLocation:location];

    if (locationDiff.x < 0) {

        if (isJumpUp == YES) { // jump down

            isJumpUp = NO;
            SKAction *actionJump = [CommanAction jumpDownRichterWithLocation:CGPointMake(location.x, yAxisOfSurface) withBack:YES];
            [richterNode runAction:actionJump];//[SKAction moveTo:location duration:0.0]];
            return;
        }
        SKAction *actionWalk = [CommanAction walkCapGuyWithTruning:ExactLocation];
        [richterNode runAction:actionWalk];
    } else {

        if (isJumpUp == YES) { //jump down

            isJumpUp = NO;
            SKAction *actionJump = [CommanAction jumpDownRichterWithLocation:CGPointMake(location.x, yAxisOfSurface)withBack:NO];
            [richterNode runAction:actionJump];//[SKAction moveTo:location duration:0.0]];
            return;
        }
        
        SKAction *actionWalk = [CommanAction walkCapGuyWithPoint:ExactLocation];
        [richterNode runAction:actionWalk];
    }
}

#pragma mark - Move to moon

- (void)moveToMoonWithLocation:(CGPoint)location {

    SKAction *moonMovement = [SKAction moveTo:CGPointMake(location.x, 0) duration:2.0];
    SKAction *moonScale = [SKAction scaleXTo:2 y:3 duration:0.0];
    [moon runAction:[SKAction group:@[moonMovement, moonScale]]]; //move to moon

    previousLocation = location;

    if (location.x > self.size.width - 40) {
        [self didUpdateToSecondScreenView];
    }
}

#pragma mark - Function to compare location

- (CGPoint)compareOneLocation:(CGPoint)oneLocation withSecondLocatio:(CGPoint)secondLocation {

    CGPoint deltaLocation;
    deltaLocation.x = oneLocation.x-secondLocation.x;
    deltaLocation.y = oneLocation.y-secondLocation.y;

    return deltaLocation;
}

#pragma mark - Move to second scene

- (void)didUpdateToSecondScreenView {

    [[NSUserDefaults standardUserDefaults]setValue:@"Second" forKey:@"SecondScene"];
    [self runAction:[SKAction runBlock:^(){

        ScreenScene3 *gameOver = [[ScreenScene3 alloc]initWithSize:CGSizeMake(self.frame.size.width,self.frame.size.height)];
        SKTransition *trnsition = [SKTransition fadeWithDuration:0.0];
        [self.view presentScene:gameOver transition:trnsition];
    }]];
}

#pragma mark - Add monster

- (void)addZoomie {

    Monster* monster = [[Monster alloc]initWithPosition:CGPointMake(200, 280) withBackgroungTexture:nil];
    [self addChild:monster];
    [monster walkZombiewithXAxis:500 toEndPoint:200];

    Monster* monster2 = [[Monster alloc]initWithPosition:CGPointMake(200, 400) withBackgroungTexture:nil];
    [self addChild:monster2];
    [monster2 walkZombiewithXAxis:950 toEndPoint:600];

   /* zombieAtlas = [SKTextureAtlas atlasNamed:ZOMBIE_ATLAS_NAME];
    zombie = [SKSpriteNode spriteNodeWithTexture:SPRITES_ZOMBIE2];
    zombie.color = [UIColor redColor];
    zombie.zPosition = 0.0;
    [zombie runAction:[SKAction scaleTo:2 duration:0.0]];
    zombie.position = CGPointMake(100, 55);
    [self addChild:zombie];*/
}

#pragma mark - Delegates of contact

- (void)didBeginContact:(SKPhysicsContact *)contact {

    SKPhysicsBody *firstBody, *secondBody;

    firstBody = contact.bodyB;
    secondBody = contact.bodyA;

    // if ((firstBody.categoryBitMask & RichterCategory ) != 0 &&  (secondBody.categoryBitMask & monsterCategory) != 0) {
    [self arrow:(SKSpriteNode *) firstBody.node didCollideWithMonster:(SKSpriteNode *) secondBody.node];
}

#pragma mark - Remove monster and arrow if they collides

- (void)arrow:(SKSpriteNode *)arrow didCollideWithMonster:(SKSpriteNode *)monster {

     NSLog(@"Hit");
    if (([arrow.name isEqualToString:@"Weapon"] && [monster.name isEqualToString:@"Monster"]) || ([monster.name isEqualToString:@"Weapon"] && [arrow.name isEqualToString:@"Monster"])) {

        [arrow removeFromParent];
        [monster removeFromParent];
        [GRModelOfLifeScore updateScoreOfNodeWithScoreToKillMonster]; //update score

    } else if (([arrow.name isEqualToString:@"star"] && [monster.name isEqualToString:@"Richter"])) {

        [GRModelOfLifeScore updateScoreOfNodeWithScoreOfStar]; //update score
        [arrow removeFromParent];
    } else if ([monster.name isEqualToString:@"star"] && [arrow.name isEqualToString:@"Richter"]) {

        [GRModelOfLifeScore updateScoreOfNodeWithScoreOfStar]; // update score
        [monster removeFromParent];
    } else {

        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SecondScene"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        NSInteger lifeCount = [[NSUserDefaults standardUserDefaults]integerForKey:@"lifeCount"];
        if (lifeCount!= 0) {

            [GRModelOfLifeScore removeNode:self.scene];

            previousLocation = CGPointMake(0.5,0.5);

            [richterNode removeFromParent];

            richterNode  = [[RichterNode alloc]initWithPosition:CGPointMake(60, yAxisOfSurface) withBackgroungTexture:nil];
            richterNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20,20)];
            [self addChild:richterNode]; //add  richter
        } else {

            SKTransition *trnsition = [SKTransition fadeWithDuration:0.1];
            GameOverScene *gameOver = [[GameOverScene alloc]initWithSize:self.size won:NO];
            [self.view presentScene:gameOver transition:trnsition];
        }
    }
}

@end
