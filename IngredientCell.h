//
//  IngredientCell.h
//  WhatToEat
//
//  Created by Creonopoulos Creon on 4/13/13.
//  Copyright (c) 2013 apt.gr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IngredientCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *IngredImage;

@property (weak, nonatomic) IBOutlet UILabel *Ingredient;

@property (weak, nonatomic) IBOutlet UILabel *Subtitle;

@end
