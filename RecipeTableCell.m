//
//  RecipeTableCell.m
//  WhatToEat
//
//  Created by Creonopoulos Creon on 3/31/13.
//  Copyright (c) 2013 apt.gr. All rights reserved.
//

#import "RecipeTableCell.h"

@implementation RecipeTableCell
@synthesize PrepTime,Difficulty,RecipeName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
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


//this method hides the Preperation time label if the cell is editing
-(void) layoutSubviews {
    
    [super layoutSubviews];
    
    if (self.isEditing)
    {
        PrepTime.hidden = TRUE;
    }
    else
    {
        PrepTime.hidden = FALSE;
    }

    

}

@end
