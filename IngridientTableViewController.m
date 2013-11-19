//
//  IngridientTableViewController.m
//  WhatToEat
//
//  Created by Creonopoulos Creon on 3/29/13.
//  Copyright (c) 2013 apt.gr. All rights reserved.
//

#import "IngridientTableViewController.h"
#import "IngredientCell.h"
#import "RecipeListViewController.h"

@interface IngridientTableViewController ()

- (BOOL)cellIsSelected:(NSIndexPath *)indexPath;

@end

@implementation IngridientTableViewController
@synthesize Ingridients,object,TableView,SelectionsArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
            }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //set the title of the view
    self.navigationItem.title = @"Select Ingredients";
    //navigation bar color
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];

    //make the selection index array all false
    for (int i = 0; i < 41; i++) {
        switchStateArr[i]=0;
    }
    
    selectedIndexes = [[NSMutableDictionary alloc] init];

    
    // Uncomment the following line to preserve selection between presentations.
    
    //give the plist a name
    NSString *plistFile = [[NSBundle mainBundle]
                           pathForResource:@"Ingredients" ofType:@"plist"];
    
    // allocate and store items in the plist to the array property
    Ingridients = [[NSMutableArray alloc] initWithContentsOfFile:plistFile];
    SelectionsArray = [[NSMutableArray alloc] init];
    self.navigationController.toolbarHidden = YES;

 

}


- (void)viewDidAppear:(BOOL)animated{
    
    self.navigationController.toolbarHidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [Ingridients count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableViewCell = @"IngredientCell";
    
    IngredientCell *cell = (IngredientCell*)[tableView dequeueReusableCellWithIdentifier:tableViewCell];
        
    object = [Ingridients objectAtIndex:indexPath.row];
    
    //initialize the selection switch
    UISwitch *theSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    
    if(cell == nil){
        
        cell = [[IngredientCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell];
        
        //set the switch state according to the switch state array when cell is null
        theSwitch.on = [[NSNumber numberWithInt:switchStateArr[indexPath.row]] boolValue];
        
        
    }
    
        //configure the cell...        
    [theSwitch addTarget:self action:@selector(SwitchToggle:) forControlEvents:UIControlEventTouchUpInside];
    theSwitch.on = [[NSNumber numberWithInt:switchStateArr[indexPath.row]] boolValue];
    cell.accessoryView = theSwitch;
    cell.Ingredient.text = [object objectForKey:@"Ingredient"];
    cell.IngredImage.image = [UIImage imageNamed:[object objectForKey:@"Image"]];
    
    //Some Ingredients need subtitles
    switch (indexPath.row) {
        case 5:
            cell.Subtitle.text = @"*Includes hot dogs";
            break;    
        case 8:
            cell.Subtitle.text = @"*Depends on type";
            break;
        case 9:
            cell.Subtitle.text = @"*Or margarine";
            break;
        case 11:
            cell.Subtitle.text = @"*Depends on type";
            break;
        case 17:
            cell.Subtitle.text = @"*Depends on type";
            break;
        case 31:
            cell.Subtitle.text = @"*Includes Jalepeno Peppers";
            break;
        default:
            cell.Subtitle.text = @"";
            break;
    }

        
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // If our cell is selected, return double height
    CGFloat kCellHeight = 60.0f;
    
    return kCellHeight;
}


#pragma mark - Table view delegate

//Left here in case of later need needed app update
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Deselect cell
    [tableView deselectRowAtIndexPath:indexPath animated:FALSE];
    
    // Toggle 'selected' state
    BOOL isSelected = ![self cellIsSelected:indexPath];
        
    
    // Store cell 'selected' state keyed on indexPath
    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
    
    //sets the value of the switch to the specific index of the mutable array
    [selectedIndexes setObject:selectedIndex forKey:indexPath];
    
    // This is where magic happens...
    [tableView beginUpdates];
    [tableView endUpdates];
}
    


- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {
	// Return whether the cell at the specified index path is selected or not
	NSNumber *selectedIndex = [selectedIndexes objectForKey:indexPath];
    
	return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
}




//Function to make the selected ingredient available
- (void)SwitchToggle:(UISwitch *)sender{
    
    
    //get the row it was sent from
    
    UIView *view = sender;
    while (![view isKindOfClass:[IngredientCell class]]) {
        view = [view superview];
    }
    IngredientCell *cell = (IngredientCell *)view;
    
    NSIndexPath *indexPath = [TableView indexPathForCell:cell];

    
    NSLog(@"%i",indexPath.row);
    
    //if the switch is on and the recipe does not already exist in selection array
    if(sender.isOn && ![SelectionsArray containsObject:[[Ingridients objectAtIndex:indexPath.row] objectForKey:@"Ingredient"]])
        {
            //add recipe to array
            [SelectionsArray addObject:[[Ingridients objectAtIndex:indexPath.row] objectForKey:@"Ingredient"]];
            //set the state of the specific row to on
            switchStateArr[indexPath.row]= 1;

            
        }
    else if(!sender.isOn)
        {
            //remove the recipe from the selection array
            [SelectionsArray removeObjectIdenticalTo:[[Ingridients objectAtIndex:indexPath.row] objectForKey:@"Ingredient"]];
            //set the state of the specific row to off
            switchStateArr[indexPath.row]= 0;
        }
        
    
    
}



//Prepare the next view before it is pushed in
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier] isEqualToString:@"RecipeListSegue"]){
    //set the recipe list to the destination controller
        RecipeListViewController *rvc = [segue destinationViewController];
    
    //set the ingredients of the selected array to the ingredients for the next view controller
        rvc.Ingredients = SelectionsArray;
        
      }

}


//method to dimiss the view if the cancel button is selected
- (IBAction)CancelButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
