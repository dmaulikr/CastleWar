//
//  AppDelegate.h
//  TexturePacker-SpriteKit
//
//  Created by joachim on 23.09.13.
//  Copyright (c) 2013 CodeAndWeb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {

    NSMutableArray *nodes;
}

@property (nonatomic,strong) NSMutableArray *nodes;

@property (strong, nonatomic) UIWindow *window;

@end
