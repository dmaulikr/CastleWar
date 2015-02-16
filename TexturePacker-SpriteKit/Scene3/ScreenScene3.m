//
//  ScreenScene2.m
//  TexturePacker-SpriteKit
//
//  Created by GrepRuby on 02/01/15.
//  Copyright (c) 2015 CodeAndWeb. All rights reserved.
//

#import "ScreenScene3.h"
#import "ScreenScene2.h"
#import "Monster.h"
#import "Weapon.h"
#import "CommanAction.h"
#import "GameOverScene.h"

#import "sprites.h"
#import "bgsprites.h"
#import "richter.h"
#import "GRModelOfLifeScore.h"

#define  yAxisOfSurface 255
#define MaxYTouch 325

static inline CGPoint rwAdd(CGPoint a, CGPoint b) {
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint rwSub(CGPoint a, CGPoint b) {
    return CGPointMake(a.x - b.x, a.y - b.y);
}

static inline CGPoint rwMult(CGPoint a, float b) {
    return CGPointMake(a.x * b, a.y * b);
}

static inline float rwLength(CGPoint a) {
    return sqrtf(a.x * a.x + a.y * a.y);
}

    // Makes a vector have a length of 1
static inline CGPoint rwNormalize(CGPoint a) {
    float length = rwLength(a);
    return CGPointMake(a.x / length, a.y / length);
}

@implementation ScreenScene3

#pragma mark - View life cycle

- (id)initWithSize:(CGSize)size {

    if (self = [super initWithSize:size]) {

        scrollVwBackground = [[ScrollingBackground alloc] initWithBackground:nil frame:CGRectMake(0, yAxisOfSurface, size.width*2, 200) speed:0.0];
        [self addChild:scrollVwBackground];
        [self initScene];
    }
    return self;
}

- (void)initScene {

    self.backgroundColor = [UIColor blackColor];

    moon = [[Moon alloc]initWithPosition:CGPointMake(50, yAxisOfSurface) withBackgroungTexture:nil];
    [self addChild:moon]; //add moon

    [self addFortBackground]; //add fort background

    background = [[BackGround alloc]initWithPosition:CGPointMake(0,0) withBackgroungTexture:SPRITES_TEX_BGSCENE2];
    [self addChild:background];
    [background runAction:[SKAction scaleXTo:2.5 y:3 duration:0.0]]; // add background

    richterNode  = [[RichterNode alloc]initWithPosition:CGPointMake(55, yAxisOfSurface) withBackgroungTexture:nil]; //ritcher node
    richterNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20,20)];
    [self addChild:richterNode];

    previousLocation = CGPointMake(0.5,0.5);

    [self addChild:[self fireButtonNode]];
    [self addZoomie];
}

- (SKSpriteNode *)fireButtonNode {

    SKSpriteNode *fireNode = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(44,44)];
    fireNode.position = CGPointMake(44, 44);
    fireNode.name = @"fireButtonNode";//how the node is identified later
    fireNode.zPosition = 1.0;
    return fireNode;
}

#pragma mark - Add Fort background

- (void)addFortBackground {

    SKSpriteNode *fortNode = [SKSpriteNode spriteNodeWithTexture:SPRITES_FORT];
    fortNode.position = CGPointMake(0, 100);
    [fortNode runAction:[SKAction scaleXTo:2.1 y:2.0 duration:0.0]];
    fortNode.anchorPoint = CGPointMake(0, 0);
    [self addChild:fortNode];
}

- (void)didMoveToView:(SKView *)view {

    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:recognizer];

    UISwipeGestureRecognizer *recognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    recognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:recognizerDown];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)sender {

    NSLog(@"%lu", sender.direction);
    if (sender.state == UIGestureRecognizerStateEnded) {

        CGPoint touchLocation = [sender locationInView:sender.view];
        touchLocation = [self convertPointFromView:touchLocation];
        if (sender.direction == UISwipeGestureRecognizerDirectionUp) {

            CGPoint ExactLocation = CGPointMake(touchLocation.x, yAxisOfSurface); //xaxis fixed for surface
            CGPoint locationDiff = [self compareOneLocation:ExactLocation withSecondLocatio:previousLocation];

            if (locationDiff.x < 0) {

                SKAction *actionJump = [CommanAction jumpRichterActionBackWithScreenSize:self.size.width];
                [richterNode runAction:actionJump];
            } else {

                SKAction *actionJump = [CommanAction jumpRichterActionWithScreenSize:self.size.width];
                [richterNode runAction:actionJump];
            }
            [self moveToMoonwithlocation:touchLocation];
            previousLocation = touchLocation;
            return;
        } else if (sender.direction == UISwipeGestureRecognizerDirectionDown) {
            NSLog(@"sit");
            SKAction *actionJump = [CommanAction sitRicher:CGPointMake(0,0)];
            [richterNode runAction:actionJump];
        }
    }
}

#pragma mark - UITouch Event

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self.scene]; // location
    SKNode *node = [self nodeAtPoint:location];
    if ([node.name isEqualToString:@"fireButtonNode"]) {
        if (isFire == NO) {
            isFire = YES;
            SKSpriteNode *btnNode = (SKSpriteNode *)node;
            btnNode.color = [UIColor greenColor];
        } else {
            isFire = NO;
            SKSpriteNode *btnNode = (SKSpriteNode *)node;
            btnNode.color = [UIColor redColor];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self.scene]; // location

    CGPoint ExactLocation = CGPointMake(location.x, yAxisOfSurface); //xaxis fixed for surface
    CGPoint locationDiff = [self compareOneLocation:ExactLocation withSecondLocatio:previousLocation];

    if (isFire  == YES) {

        if (location.y <200) {
            return;
        }
        [self addWeaponWithLocation:location];
        return;
    } else {

        if (location.y > MaxYTouch || location.y <200) {
            return;
        }
        [self moveToMoonwithlocation:location];

        if (locationDiff.x < 0) {

            SKAction *actionWalk = [CommanAction walkCapGuyWithTruning:ExactLocation];
            [richterNode runAction:actionWalk];
        } else {

            SKAction *actionWalk = [CommanAction walkCapGuyWithPoint:ExactLocation];
            [richterNode runAction:actionWalk];
        }
    }
}

- (void)addWeaponWithLocation:(CGPoint)location {

    if (FireNumber > 15) {
        return;
    }
    FireNumber ++;
    Weapon *weaponeNode1 = [[Weapon alloc]initWithPosition:CGPointMake(richterNode.frame.origin.x+10, 280) withBackgroungTexture:WEAPON_001];
    [self addChild:weaponeNode1];

    CGPoint offset = rwSub(location, weaponeNode1.position); //Arrow offset

        //Get the direction of where to shoot
    CGPoint direction = rwNormalize(offset);
    CGPoint shootAmount = rwMult(direction, 1000);
        //Add the shoot amount to the current position
    CGPoint realDest = rwAdd(shootAmount, weaponeNode1.position);

    SKAction *laserMoveAction = [SKAction moveTo:realDest duration:0.3];
    SKAction *remove = [SKAction removeFromParent];
    [weaponeNode1 runAction:[SKAction sequence:@[laserMoveAction, remove]]];
}


#pragma mark - Move to moon

- (void)moveToMoonwithlocation:(CGPoint)location {

    SKAction *moonMovement = [SKAction moveTo:CGPointMake(location.x, 0) duration:1.5];
    SKAction *moonScale = [SKAction scaleXTo:2 y:3 duration:0.0];
    [moon runAction:[SKAction group:@[moonMovement, moonScale]]]; //move to moon

    previousLocation = location;

    if (location.x < 40) {
        [self didUpdateFirstView];
    }
}

#pragma mark - Function to compare location

- (CGPoint)compareOneLocation:(CGPoint)oneLocation withSecondLocatio:(CGPoint)secondLocation {

    CGPoint deltaLocation;
    deltaLocation.x = oneLocation.x-secondLocation.x;
    deltaLocation.y = oneLocation.y-secondLocation.y;
    return deltaLocation;
}

#pragma mark - Move to First scene from this screen

- (void)didUpdateFirstView {

    [self runAction:[SKAction runBlock:^(){

        ScreenScene2 *gameOver = [[ScreenScene2 alloc]initWithSize:CGSizeMake(self.frame.size.width,self.frame.size.height)];
        SKTransition *trnsition = [SKTransition fadeWithDuration:0.0];
        [self.view presentScene:gameOver transition:trnsition];
    }]];
}

#pragma mark - Add monster

- (void)addZoomie {

    Monster* monster = [[Monster alloc]initWithPosition:CGPointMake(200, 280) withBackgroungTexture:nil];
    [self addChild:monster];
    [monster walkZombiewithXAxis:500 toEndPoint:200];

    SKAction *action = [SKAction rotateByAngle:M_PI duration:1.0];
    monster.physicsBody.angularDamping = 10;
    [monster runAction:[SKAction repeatActionForever:action]];

    Monster* monster2 = [[Monster alloc]initWithPosition:CGPointMake(200, 400) withBackgroungTexture:nil];
    [self addChild:monster2];
    [monster2 walkZombiewithXAxis:950 toEndPoint:600];

    Monster* monster3 = [[Monster alloc]initWithPosition:CGPointMake(570, 300) withBackgroungTexture:nil];
        //monster3.speed = 2;
    [monster3 walkZombiewithXAxis:1250 toEndPoint:600];
    [self addChild:monster3];

    Monster* monster4 = [[Monster alloc]initWithPosition:CGPointMake(self.size.width - 100, 330) withBackgroungTexture:nil];
    monster4.speed = 100;
    SKAction *action1 = [SKAction rotateByAngle:M_PI duration:1.0];
    [monster4 runAction:[SKAction repeatActionForever:action1]];
    [self addChild:monster4];
}

#pragma mark - Delegates of contact

- (void)didBeginContact:(SKPhysicsContact *)contact {

    SKPhysicsBody *firstBody, *secondBody;

    firstBody = contact.bodyB;
    secondBody = contact.bodyA;
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

            [richterNode removeFromParent];
            previousLocation = CGPointMake(0.5,0.5);
            richterNode  = [[RichterNode alloc]initWithPosition:CGPointMake(50, yAxisOfSurface) withBackgroungTexture:nil];
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
