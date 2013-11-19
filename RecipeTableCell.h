//
//  RecipeTableCell.h
//  WhatToEat
//
//  Created by Creonopoulos Creon on 3/31/13.
//  Copyright (c) 2013 apt.gr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *PrepTime;

@property (weak, nonatomic) IBOutlet UILabel *RecipeName;

@property (weak, nonatomic) IBOutlet UILabel *Difficulty;

@property (weak, nonatomic) IBOutlet UILabel *MissingAlert;
@end
