//
//  RecipeDetailViewController.m
//  WhatToEat
//
//  Created by Creonopoulos Creon on 4/1/13.
//  Copyright (c) 2013 apt.gr. All rights reserved.
//

#import "RecipeDetailViewController.h"
#import "AppDelegate.h"
#import "FavoritesViewController.h"

@interface RecipeDetailViewController ()

@end

@implementation RecipeDetailViewController
@synthesize RecipeTitle,PrepTime,Directions,RecipeImage,Recipes,myPickerView,searchArray,NoIngWarningBtn,background,Calories,Servings,AddFavoriteButton,TimerBarButton,OpenTimerButton,CloseTimerButton,PickerContainerView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImage *missingImg = [UIImage imageNamed:@"warning-icon.png"];
        
        missingImg = [missingImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [self.NoIngWarningBtn setImage:missingImg];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TimerBarButton = [[UIToolbar alloc] init];
    PickerContainerView.hidden=TRUE;

    self.navigationController.toolbarHidden = NO;

    // Do any additional setup after loading the view.
    
    //If the view is coming from the favorites list, the missing ingredietns button is null so the add favorites is disabled
    if (self.navigationItem.rightBarButtonItem == nil) {
        
        self.AddFavoriteButton.enabled = FALSE;
    }
        
    //make an array with seconds
    for (int i = 0; i< 60; i++) {
        secondsArray[i] = i;
    }
    
    //fill an array with minutes
    for (int i = 0; i<= 180; i++) {
        minArray[i] = i;
    }
    
    //Initialize the array of missing ingredients
    missingIng = [[NSMutableArray alloc] init];

    
    //if the number of Ingredients of the recipe is not equal to the number of Ingredients required
    if(![searchArray containsObject:[Recipes objectForKey:@"SearchWords"]])
    {
        //for every ingredient in the required ingredients
        for (NSString *ingr in [Recipes objectForKey:@"SearchWords"]) {
            
                //if the ingredient is not already in the missing Ingredients array
                if (![searchArray containsObject:ingr]) {
                    //add the ingredient to the missing Ingredients array
                    [missingIng addObject:ingr];
                }
        }
        
    }
    
    //if there are no missing ingredients, the warning button does not show
    if ([missingIng count] == 0) {
        
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    //Set the information of the view
    RecipeTitle.text = [Recipes objectForKey:@"RecipeName"];
    
    PrepTime.text = [Recipes objectForKey:@"PrepTime"];
    
    RecipeImage.image = [UIImage imageNamed:[Recipes objectForKey:@"Image"]];
    
    Servings.text = [Recipes objectForKey:@"Servings"];
    
    Calories.text = [Recipes objectForKey:@"Calories"];

    Directions.text = [Recipes objectForKey:@"Directions"];

    //set the background image
    background.image = [UIImage imageNamed:@"OpenFridge.png"];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Function that starts a timer according to the given time
-(void)timerRun{
    
    //Initialize an alert view to inform the time is up
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time is up!!" message:nil delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Start Again", nil];
    
    //set the timer alarm tag to 1
    [alert setTag:1];
    
    //load a sound for the alert
    NSString *songName = [[NSBundle mainBundle] pathForResource:@"Alarm" ofType:@"mp3"];
    
    //initialize the Audio Player with the song name
    alarmRing = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:songName] error:nil];
    
    //reset the minutes member to 60 when seconds has reached 0
    if(seconds <= 0)
    {
        seconds = 60;
        minutes -=1;
    }
    
    //dicrement the seconds
    seconds -=1;
    
    //Set the timer button to the timer display
    NSString *timerTitle = [NSString stringWithFormat:@"%2d:%.2d",minutes,seconds];
    OpenTimerButton.title = timerTitle;
    //Timer button is not enabled while timer is running
    OpenTimerButton.enabled = FALSE;
    
    
    //When minutes and seconds both reach 0
    if(minutes < 0)
    {
        
        //stop the timer
        [timer invalidate];
        //Reset minutes and seconds
        OpenTimerButton.title = @"Open Timer";
        //set timer to null
        timer = nil;
        //show the done alert
        [alert show];
        //play the alarm sound
        [alarmRing play];
        //keep playing sound until interrupted
        alarmRing.numberOfLoops=-1;
    }
    
}



//Initialization of a timer object that calls the timerRun method
- (void)setTimer{
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
}


//Close the timer view and stop the timer method
- (IBAction)CloseTimer:(id)sender {
    
    PickerContainerView.hidden=TRUE;
    //Invalidate the timer object
    [timer invalidate];
    //Reset the start timer button title
    OpenTimerButton.title = @"Open Timer";
    //Enable the start timer
    OpenTimerButton.enabled = TRUE;
    //Reset the title of the stop timer button
    CloseTimerButton.title = @"Close Timer";
    
    
    
}

//Show the timer container view method
- (IBAction)OpenTimer:(id)sender {
    
    PickerContainerView.hidden=FALSE;
    
}


// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if(component == 0)
        return 181;
    else
        return 60;
    
}


// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}


//This method sets the selected minutes and seconds from the picker view to the according data members
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    minutes = minArray[[pickerView selectedRowInComponent:0]];
    seconds = secondsArray[[pickerView selectedRowInComponent:1]];
    tempMins = minutes;
    tempSecs = seconds;
}


//Title for each row (both are numbers form 0-59 so no need to change that.
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    UILabel *minsLabel = [[UILabel alloc] initWithFrame:CGRectMake(148, 93, 80, 30)];
    minsLabel.text = @"mins";
    minsLabel.font = [UIFont boldSystemFontOfSize:18];
    minsLabel.backgroundColor = [UIColor clearColor];
    minsLabel.shadowColor = [UIColor whiteColor];
    minsLabel.shadowOffset = CGSizeMake (0,1);
    [pickerView insertSubview:minsLabel aboveSubview:[pickerView.subviews objectAtIndex:1]];
    
    UILabel *secLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 93, 80, 30)];
    secLabel.text = @"secs";
    secLabel.font = [UIFont boldSystemFontOfSize:18];
    secLabel.backgroundColor = [UIColor clearColor];
    secLabel.shadowColor = [UIColor whiteColor];
    secLabel.shadowOffset = CGSizeMake (0,1);
    [pickerView insertSubview:secLabel aboveSubview:[pickerView.subviews objectAtIndex:1]];
    
    NSString *returnStr = @"";
    
    
    if (component == 0)
    {
        returnStr = [NSString stringWithFormat:@"%i",minArray[row]];
    }
    else
    {
        returnStr = [NSString stringWithFormat:@"%i",secondsArray[row]];
    }
    
    return returnStr;
}


// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return 70.0;
    
}


//Add functionality to the missing ingredients button in the navigation bar
- (IBAction)NoIngWarning:(id)sender {
    
    //Add in a string the Ingredients missing array components
    NSString *alertString = [missingIng componentsJoinedByString:@", "];
    
    // Initialize an alert view with the ingredients missing
    UIAlertView *IngrAlert = [[UIAlertView alloc] initWithTitle:@"You are missing Ingredients:" message:alertString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Add ingredients", nil];
    
    [IngrAlert setTag:2];
    
    //show the alert
    [IngrAlert show];
    
}

//this method is called when the + button is pressed to add the recipe to the favorites
- (IBAction)AddFavorite:(id)sender {
    
    UIAlertView *FavoriteAlert = [[UIAlertView alloc] initWithTitle:@"Would you like to add this recipe to your Favorite recipes?" message:nil delegate:self cancelButtonTitle:@"No, thank you" otherButtonTitles:@"Add Recipe", nil];
    
    [FavoriteAlert setTag:3];
    //show the alert
    [FavoriteAlert show];

}

- (IBAction)StartTimer:(id)sender {
    [self setTimer];
    CloseTimerButton.title = @"Close Timer";
    PickerContainerView.hidden=TRUE;
}



//Alert view method to handle button touches on it
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    
    switch (alertView.tag) {
        case 1:
        //If the alert is the timer alert
        {
        //if user clicks Restart Timer
            if(buttonIndex == 1)
            {
            //store the minutes and seconds selected at first
               minutes = tempMins;
            seconds = tempSecs;
            //Initialize a timer object again
            [self setTimer];
            //Enable the stop timer button
            //Stop the alarm sound
            [alarmRing stop];
            }
            //if the Dismiss button is selected
            else
            {
                //Reset the start timer button title
                OpenTimerButton.title = @"Open Timer";
                //Enebale the start timer button
                OpenTimerButton.enabled = TRUE;
                //Disable the stop timer button
                //stop the alarm sound
                [alarmRing stop];
                //if the "Add Ingredient" is selected
            }
            break;
        }
        //If the alert view is the missing Ingredient alert    
        case 2:
        {
            
            if(buttonIndex == 1)
            {
                //go to the Ingredient selection view
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            break;

        }
        //If the alert is the adding to favorites
        case 3:
        {
            
            if(buttonIndex == 1)
            {
            NSString *addedMessage;
            
            //Create an object of the apps delegate to access the favorites array
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                
            //as long as the recipe does not already exist in the list
            if(![appDelegate.favoritesArr containsObject:Recipes]){
                addedMessage = @"Recipe added to Favorites";
                [appDelegate.favoritesArr addObject:Recipes];
            }
            else
                addedMessage = @"Recipe already exists in Favorites";
                
            //message after adding the recipe
            UIAlertView *AddedAlert = [[UIAlertView alloc] initWithTitle:addedMessage
            message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [AddedAlert show];
            }
            
            break;
                
        }
    
   }


}


@end
