//
//  RecipeListViewController.h
//  WhatToEat
//
//  Created by Creonopoulos Creon on 3/31/13.
//  Copyright (c) 2013 apt.gr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeListViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *Recipies;

@property (nonatomic,retain) NSMutableArray *Ingredients;

@property (nonatomic,retain)NSMutableArray *searchArray;

@property (nonatomic,retain)NSMutableArray *results;

@property (nonatomic, retain) NSDictionary *object;


@end
