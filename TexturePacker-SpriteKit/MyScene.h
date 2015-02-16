//
//  MyScene.h
//  TexturePacker-SpriteKit
//
//  Created by joachim on 23.09.13.
//  Copyright (c) 2013 CodeAndWeb. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "RichterNode.h"
#import "BackGround.h"
#import "SuperScene.h"

@interface MyScene : SuperScene {

    RichterNode *richterNode;
    BackGround *bgNode;
    CGPoint previousLocation;
    SKTextureAtlas *gameAtlasRichter;
    SKTextureAtlas *ritchterAtlas;
}

@property(strong) SKAction *sequence;
@property(strong) SKTextureAtlas *atlas;

    //https://github.com/ioscreator/ioscreator


@end
