//
//  AppDelegate.h
//  WhatToEat
//
//  Created by Creonopoulos Creon on 3/29/13.
//  Copyright (c) 2013 apt.gr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,retain)NSMutableArray *favoritesArr;

@property (nonatomic,retain)NSUserDefaults *defaults;


@end
