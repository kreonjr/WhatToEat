//
//  RecipeDetailViewController.h
//  WhatToEat
//
//  Created by Creonopoulos Creon on 4/1/13.
//  Copyright (c) 2013 apt.gr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RecipeDetailViewController : UIViewController <UIPickerViewDelegate> {
    
    int secondsArray[60];           //holds the seconds
    int minArray[181];              //holds the minutes
    int minutes;                    //holds the minute to display
    int seconds;                    //holds the second to display
    int tempMins, tempSecs;         //holds the minutes and seconds if the user wants to restart the timer
    NSMutableArray *missingIng;     //An array with missing ingredients for the resipe
    AVAudioPlayer *alarmRing;       //Timer alarm sound
    NSTimer *timer;                 //timer object

    
}


@property (nonatomic,retain) NSDictionary *Recipes;

@property (retain, nonatomic) IBOutlet UIPickerView *myPickerView;

@property (nonatomic, retain)NSMutableArray *searchArray;

@property (nonatomic,retain)NSMutableArray *RecipeList;

@property (weak, nonatomic) IBOutlet UIImageView *background;

@property (weak, nonatomic) IBOutlet UIImageView *RecipeImage;

@property (weak, nonatomic) IBOutlet UILabel *RecipeTitle;

@property (weak, nonatomic) IBOutlet UITextView *Directions;

@property (weak, nonatomic) IBOutlet UILabel *PrepTime;

@property (weak, nonatomic) IBOutlet UILabel *Calories;

@property (weak, nonatomic) IBOutlet UILabel *Servings;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *NoIngWarningBtn;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *AddFavoriteButton;

@property (weak, nonatomic) IBOutlet UIView *PickerContainerView;

@property (retain, nonatomic) IBOutlet UIToolbar *TimerBarButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *OpenTimerButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *CloseTimerButton;


- (IBAction)NoIngWarning:(id)sender;

- (IBAction)AddFavorite:(id)sender;

- (IBAction)StartTimer:(id)sender;

- (IBAction)CloseTimer:(id)sender;

- (IBAction)OpenTimer:(id)sender;
@end
