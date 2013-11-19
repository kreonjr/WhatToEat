//
//  FavoritesViewController.m
//  WhatToEat
//
//  Created by Creonopoulos Creon on 4/19/13.
//  Copyright (c) 2013 apt.gr. All rights reserved.
//

#import "FavoritesViewController.h"
#import "RecipeTableCell.h"
#import "RecipeDetailViewController.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController
@synthesize object,Recipies;

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
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"RecipeBackground.png"]];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    //Create an appDelegate object to access the saved recipes array
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    Recipies = [[NSMutableArray alloc] initWithArray:appDelegate.favoritesArr];
    
    //Making the table view editable
    //UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(Remove:)];
    //[self.navigationItem setRightBarButtonItem:deleteButton];
    
    if([Recipies count] == 0)
    {
        //Initialize an alert view to tel the user that no ingredients were selected
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty" message:@"Favorites is Empty" delegate:self cancelButtonTitle:@"Back" otherButtonTitles:nil, nil];
        
        //show the alert
        [alert show];
        
    }
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
    return [Recipies count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RecipeCell";
    RecipeTableCell *cell = (RecipeTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    object = [Recipies objectAtIndex:indexPath.row];
    
    if(cell == nil)
    {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RecipeTableCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
        
    }
    
    
    
    //hide the missing ingredients alert
    cell.MissingAlert.hidden = true;
    
    //if the number of ingredients selected is not equal to the number of required ingredients
        
    
    // Configure the cell...
    cell.RecipeName.text = [object objectForKey:@"RecipeName"];
    
    cell.PrepTime.text = [object objectForKey:@"PrepTime"];
    
    cell.Difficulty.text = [object objectForKey:@"Difficulty"];
    
    return cell;

}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //perform the segue push
    [self performSegueWithIdentifier:@"FavRecipeDetailSegue" sender:self];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Do whatever data deletion you need to do...
        
        [appDelegate.favoritesArr removeObjectAtIndex:indexPath.row];
        [Recipies removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
    }
    [tableView endUpdates];
}



//prepare the next view for push
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //get the index path of the selected cell
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if([[segue identifier] isEqualToString:@"FavRecipeDetailSegue"])
    {
        //make the recipe detail the destination view controller
        RecipeDetailViewController *RDVC = [segue destinationViewController];
        
        //set the information of the specific recipe to the data of the destination view controller
        RDVC.Recipes = [Recipies objectAtIndex:indexPath.row];
        RDVC.navigationItem.rightBarButtonItem = nil;
        
    }
    
}

//Alert view method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //when user clicks the back button of the alert view, the view goes back to main view
    if(buttonIndex == 0)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


//method to dismiss the view on click of back button
- (IBAction)BackButton:(id)sender {
    
        [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
