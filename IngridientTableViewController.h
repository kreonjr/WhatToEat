//
//  IngridientTableViewController.h
//  WhatToEat
//
//  Created by Creonopoulos Creon on 3/29/13.
//  Copyright (c) 2013 apt.gr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IngridientTableViewController : UITableViewController{
    
    //array to hold index of selected ingredients
    int switchStateArr[42];
    NSMutableDictionary *selectedIndexes;

}


//Array to hold the ingridients
@property (nonatomic,retain)NSMutableArray *Ingridients;

//array to hold the selected ingridients
@property (nonatomic,retain)NSMutableArray *SelectionsArray;

//dictionary to add info to the table data source
@property (nonatomic, retain)NSMutableDictionary *object;

//the table view of the view
@property (strong, nonatomic) IBOutlet UITableView *TableView;

//Cancel button
- (IBAction)CancelButton:(id)sender;



@end