//
//  MyScene.m
//  TexturePacker-SpriteKit
//
//  Created by joachim on 23.09.13.
//  Copyright (c) 2013 CodeAndWeb. All rights reserved.
//

#import "MyScene.h"
#import "ScreenScene2.h"
#import "CommanAction.h"

#import "sprites.h"
#import "bgsprites.h"
#import "richter.h"
#import "Star.h"
#import "GRModelOfLifeScore.h"
#import "GRDemoVideo.h"

#define yAxisOfSurface 170

@implementation MyScene

@synthesize sequence;

- (id)initWithSize:(CGSize)size {

    if (self = [super initWithSize:size]) {

        [self initScene];
    }
    return self;
}

- (void)initScene {

        //Add video
        // GRDemoVideo *video = [[GRDemoVideo alloc]initWithFrame:CGRectMake(500, 300, self.frame.size.width, self.frame.size.height) withUrl:@"Video" ofType:@"mov"];
        // [self addChild:video];

    bgNode = [[BackGround alloc]initWithPosition:CGPointMake(0,0) withBackgroungTexture:SPRITES_TEX_BG];
    [bgNode runAction:[SKAction scaleXTo:3 y:1.5 duration:0.0]];

    [self addChild:bgNode];

    richterNode  = [[RichterNode alloc]initWithPosition:CGPointMake(100, yAxisOfSurface) withBackgroungTexture:nil];
    richterNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20,20)];
    [self addChild:richterNode];

    previousLocation = CGPointMake(0.5,0.5);

        //[self addChild:[GRModelOfLifeScore addExtraNodeLife]];// add life
   /* ritchterAtlas = [SKTextureAtlas atlasNamed:RICHTER_ATLAS_NAME];
    richterNode = [SKSpriteNode spriteNodeWithTexture:RICHTER_WALK_0001];
    richterNode.position = CGPointMake(100, 170);
    [richterNode runAction:[SKAction scaleTo:3 duration:0.0]];
    richterNode.zPosition = 1;
    richterNode.anchorPoint = CGPointMake(0, 0);*/
}

- (void)didMoveToView:(SKView *)view {

    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:recognizer];

    UISwipeGestureRecognizer *recognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    recognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:recognizerDown];

    int y = 190;
    for (int i=0; i<8; i++) {

        int x = [CommanAction addStarsAtXPositionAtRandomPlaceWithWidth:self.size.width];

        Star *satrs = [[Star alloc]initWithPosition:CGPointMake(x, y) withBackgroungTexture:nil];
        [self addChild:satrs];

        if (i%2 == 0) {
            y = y +50;
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self.scene]; // location

    if (location.x > (self.size.width - 136)) {

        [self moveToNextScene];
    }

    if (location.y > 250) {
        return;
    }
    CGPoint ExactLocation = CGPointMake(location.x, 170 + [self moveUpRichter:location]); //xaxis fixed for surface
    CGPoint locationDiff = [self compareOneLocation:ExactLocation withSecondLocatio:previousLocation];
    if (locationDiff.x < 0) {
        SKAction *actionWalk = [CommanAction walkCapGuyWithTruning:ExactLocation];
        [richterNode runAction:actionWalk];
    } else {
        SKAction *actionWalk = [CommanAction walkCapGuyWithPoint:ExactLocation];
        [richterNode runAction:actionWalk];
    }
    previousLocation = location;
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
                previousLocation = CGPointMake(locationDiff.x-320, locationDiff.y);
            } else {

                SKAction *actionJump = [CommanAction jumpRichterActionWithScreenSize:self.size.width];
                [richterNode runAction:actionJump];
                previousLocation = CGPointMake(locationDiff.x+320, locationDiff.y);
            }
            return;
        } else if (sender.direction == UISwipeGestureRecognizerDirectionDown) {

            NSLog(@"sit");

            SKAction *actionJump = [CommanAction sitRicher:CGPointMake(0,0)];
            [richterNode runAction:actionJump];
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(standUpRicher) userInfo:nil repeats:NO];
        }
    }
}

- (void)standUpRicher {

    SKAction *stand = [CommanAction standUpRicher];
    [richterNode runAction:stand];
}

- (int)moveUpRichter:(CGPoint)location {

    int moveUpSXAxis = 0;
    if (location.x > 560) {
        moveUpSXAxis = 15;
    }
    return moveUpSXAxis;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

}

- (void)moveToNextScene {

    [self runAction:[SKAction runBlock:^(){

        ScreenScene2 *gameOver = [[ScreenScene2 alloc]initWithSize:CGSizeMake(self.frame.size.width,self.frame.size.height)];
        SKTransition *trnsition = [SKTransition fadeWithDuration:0.1];
        [self.view presentScene:gameOver transition:trnsition];
    }]];
}

- (CGPoint)compareOneLocation:(CGPoint)oneLocation withSecondLocatio:(CGPoint)secondLocation {

    CGPoint deltaLocation;
    deltaLocation.x = oneLocation.x-secondLocation.x;
    deltaLocation.y = oneLocation.y-secondLocation.y;

    return deltaLocation;
}

- (void)didBeginContact:(SKPhysicsContact *)contact {

    SKPhysicsBody *firstBody, *secondBody;

    firstBody = contact.bodyB;
    secondBody = contact.bodyA;

    [self arrow:(SKSpriteNode *) firstBody.node didCollideWithMonster:(SKSpriteNode *) secondBody.node];
}

- (void)arrow:(SKSpriteNode *)arrow didCollideWithMonster:(SKSpriteNode *)monster {

    if (([arrow.name isEqualToString:@"star"] && [monster.name isEqualToString:@"Richter"])) {

        [arrow removeFromParent];
        [GRModelOfLifeScore updateScoreOfNodeWithScoreOfStar];
    } else if  ([monster.name isEqualToString:@"star"] && [arrow.name isEqualToString:@"Richter"]) {

        [arrow removeFromParent];
        [GRModelOfLifeScore updateScoreOfNodeWithScoreOfStar];
    }
}

/* Walking texture sequence

Set walk texture with frame
Set walk sequence animation
Set move location with duration
Group sequence animation with move location
 */

/*- (void)walkCapGuyWithPoint:(CGPoint)location {

    // in the first animation CapGuy walks from left to right, in the second one he turns from right to left
    SKAction *walk = [SKAction animateWithTextures:RICHRET_ANIM_CAPGUY_WALK timePerFrame:0.08];
    //SKAction *turn = [SKAction animateWithTextures:SPRITES_ANIM_CAPGUY_TURN timePerFrame:0.03];
    
    SKAction *walkAnim = [SKAction sequence:@[walk, walk]];

    // we define two actions to move the sprite from left to right, and back;
    SKAction *moveRight  = [SKAction moveTo:location duration:walkAnim.duration];

    // as we have only an animation with the CapGuy walking from left to right, we use a 'scale' action
    // to get a mirrored animation.
    SKAction *resetDirection   = [SKAction scaleXTo:3  y:3 duration:0.0];

    // Action within a group are executed in parallel:
    SKAction *walkAndMoveRight = [SKAction group:@[resetDirection,walkAnim, moveRight]];
    [richterNode runAction:walkAndMoveRight];
}

- (void)walkCapGuyWithTruning:(CGPoint)location {

    // in the first animation CapGuy walks from left to right, in the second one he turns from right to left
    SKAction *walk = [SKAction animateWithTextures:RICHRET_ANIM_CAPGUY_WALK timePerFrame:0.08];
    // SKAction *turn = [SKAction animateWithTextures:SPRITES_ANIM_CAPGUY_TURN timePerFrame:0.03];

    SKAction *walkAnim = [SKAction sequence:@[walk, walk]];

    // we define two actions to move the sprite from left to right, and back;
    SKAction *moveLeft   =  [SKAction moveTo:location duration:walkAnim.duration];

    // we use a 'scale' action to get a mirrored animation.
    SKAction *mirrorDirection  = [SKAction scaleXTo:-3 y:3 duration:0.0];

    // Action within a group are executed in parallel:
    SKAction *walkAndMoveLeft  = [SKAction group:@[mirrorDirection, walkAnim, moveLeft]];

    // now we combine the walk+turn actions into a sequence, and repeat it forever
    // self.sequence = [SKAction repeatAction:[SKAction sequence:@[walkAndMoveLeft]] count:1];
    [richterNode runAction:walkAndMoveLeft];
}*/

@end
