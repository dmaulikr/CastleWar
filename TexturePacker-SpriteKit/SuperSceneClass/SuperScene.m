//
//  SuperScene.m
//  TexturePacker-SpriteKit
//
//  Created by GrepRuby on 09/01/15.
//  Copyright (c) 2015 CodeAndWeb. All rights reserved.
//

#import "SuperScene.h"
#import "GRModelOfLifeScore.h"

@implementation SuperScene

- (id)initWithSize:(CGSize)size {

    if (self = [super initWithSize:size]) {

        self.physicsWorld.gravity = CGVectorMake(0,0);
        if (sharedAppDelegate.nodes == nil) {

            sharedAppDelegate.nodes = [[NSMutableArray alloc]init];
            id arryOfNode = [GRModelOfLifeScore initWithSize:CGSizeMake(self.size.width, self.size.height)];
            sharedAppDelegate.nodes = (NSMutableArray *)arryOfNode; //Add Nodes
        }
        [self addNodeLife];

        self.physicsWorld.contactDelegate = self;
    }
    return self;
}


- (void)addNodeLife {

        //Add nodes on scene
    for (id node in sharedAppDelegate.nodes) {
        [node removeFromParent];
    }
    for (id node in sharedAppDelegate.nodes) {
        [self addChild:node];
    }
}

@end
