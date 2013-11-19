//
//  MainViewController.m
//  WhatToEat
//
//  Created by Creonopoulos Creon on 3/29/13.
//  Copyright (c) 2013 apt.gr. All rights reserved.
//

#import "MainViewController.h"
#import "FavoritesViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, tyically from a nib.
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
   
    
    //Adding animation to a label giving directions to the user by starting it off screen to the right and moving it off screen to the left.
    UILabel* lblTime = [[UILabel alloc] initWithFrame:CGRectMake(350, 510, 600, 40)];
    [self.view addSubview:lblTime];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:10];
    //infinite loop
    [UIView setAnimationRepeatCount:HUGE_VALF];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    [lblTime setText:@"Tap anywhere or slide door to open the fridge!!"];
    [lblTime setTextAlignment:NSTextAlignmentLeft];
    [lblTime setFont:[UIFont systemFontOfSize:25]];
    [lblTime setBackgroundColor:[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0]];
    lblTime.frame = CGRectMake(-600, 510, 600, 40);
    [UIView commitAnimations];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
