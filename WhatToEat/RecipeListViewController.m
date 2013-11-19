//
//  RecipeListViewController.m
//  WhatToEat
//
//  Created by Creonopoulos Creon on 3/31/13.
//  Copyright (c) 2013 apt.gr. All rights reserved.
//

#import "RecipeListViewController.h"
#import "RecipeTableCell.h"
#import "RecipeDetailViewController.h"

@interface RecipeListViewController ()

@end

@implementation RecipeListViewController
@synthesize Recipies,Ingredients,object,searchArray,results;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //set the background color of the view
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"RecipeBackground.png"]];
    
    //Set the Title of the view
    self.navigationItem.title = @"Recipies";
    
    //If the user selected no Ingredients
    if([Ingredients count] == 0)
    {        
        //Initialize an alert view to tel the user that no ingredients were selected
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty" message:@"How are you going to cook anything without ingredients?" delegate:self cancelButtonTitle:@"Back" otherButtonTitles:nil, nil];
        
        //show the alert
        [alert show];

    
    }
    
    //Setting a string with the plist data position
    NSString *plistFile = [[NSBundle mainBundle]
                           pathForResource:@"Recipes" ofType:@"plist"];
    
    // allocate and store items in the plist to the array property
    Recipies = [[NSMutableArray alloc] initWithContentsOfFile:plistFile];
    
    //Initialize an array to hold recepies and a predicate to use for search
    results = [[NSMutableArray alloc] init];
    NSPredicate *predicate;
    
    BOOL isThere;
    //For every recipe
    for (int j = 0; j < [Recipies count]; j++)
    {
            //for every ingredient
            for (int i = 0; i < [Ingredients count]; i++)
            {
                //Create a string with the Ingredient
               // NSString *searchText = Ingredients[i];
        
                //check if the ingredient is in the array of needed ingredients for the recipe
                predicate = [NSPredicate predicateWithFormat:@"%@ IN %@", [Ingredients objectAtIndex:i], [[Recipies objectAtIndex:j] objectForKey:@"SearchWords"]];
                
                //if the ingredient is there set isThere bool to true
                isThere = [predicate evaluateWithObject:[Ingredients objectAtIndex:i]];
                
                //if the bool is true and the result dictionary does not already contain the recipe
                if(isThere && ![results containsObject:[Recipies objectAtIndex:j]])
                {
                    //add the recipe to the recipe array to fill the table with
                    [results addObject:[Recipies objectAtIndex:j]];
                }
            
            }
        
        
    
    }
    

    
    
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
    return [results count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RecipeCell";
    RecipeTableCell *cell = (RecipeTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    object = [results objectAtIndex:indexPath.row];
    
    if(cell == nil)
    {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RecipeTableCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
        
                
    }
    
  
    
    //hide the missing ingredients alert
    cell.MissingAlert.hidden = true;

    //if the number of ingredients selected is not equal to the number of required ingredients
    if(![Ingredients containsObject:[object objectForKey:@"SearchWords"]])
    {
        //for every ingredient in the required ingredients array
        for (NSString *ingr in [object objectForKey:@"SearchWords"]) {
            
            //if the ingredients array does not contain the required ingredient
            if (![Ingredients containsObject:ingr]) {
                //Show the missing ingredients alert
                cell.MissingAlert.hidden = false;
            }
        }
        
    }
    
    
    // Configure the cell...
    cell.RecipeName.text = [object objectForKey:@"RecipeName"];
    
    cell.PrepTime.text = [object objectForKey:@"PrepTime"];
    
    cell.Difficulty.text = [object objectForKey:@"Difficulty"];
    
    return cell;
}

#pragma mark - Table view delegate


//Table cells are not editable
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return FALSE;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //perform the segue push
    [self performSegueWithIdentifier:@"RecipeDetailSegue" sender:self];
}



//prepare the next view for push
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //get the index path of the selected cell
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if([[segue identifier] isEqualToString:@"RecipeDetailSegue"])
    {
        //make the recipe detail the destination view controller
        RecipeDetailViewController *RecipeDetailViewController = [segue destinationViewController];
        
        //set the information of the specific recipe to the data of the destination view controller
        RecipeDetailViewController.Recipes = [results objectAtIndex:indexPath.row];
        RecipeDetailViewController.searchArray = Ingredients;
                
    }
    
}


//Method to provide functionality to the alert view button
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //when user clicks the back button of the alert view, the view goes to the ingredients list view
    if(buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
