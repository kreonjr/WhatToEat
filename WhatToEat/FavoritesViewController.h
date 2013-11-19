//
//  FavoritesViewController.h
//  WhatToEat
//
//  Created by Creonopoulos Creon on 4/19/13.
//  Copyright (c) 2013 apt.gr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface FavoritesViewController : UITableViewController
{
    AppDelegate *appDelegate;
}

@property (nonatomic, retain) NSDictionary *object;

@property (nonatomic,retain) NSMutableArray *Recipies;

- (IBAction)BackButton:(id)sender;

@end
