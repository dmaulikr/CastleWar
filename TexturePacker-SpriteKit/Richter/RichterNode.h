//
//  Richter.h
//  TexturePacker-SpriteKit
//
//  Created by GrepRuby on 02/01/15.
//  Copyright (c) 2015 CodeAndWeb. All rights reserved.
//

#import "GameObject.h"

@interface RichterNode : GameObject {

    SKTextureAtlas *atlas;
}

- (void)addRichterPosition:(CGPoint)posit;

@end
