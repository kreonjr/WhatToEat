//
//  IngredientCell.m
//  WhatToEat
//
//  Created by Creonopoulos Creon on 4/13/13.
//  Copyright (c) 2013 apt.gr. All rights reserved.
//

#import "IngredientCell.h"

@implementation IngredientCell

@synthesize Ingredient=_Ingredient,IngredImage=_IngredImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
