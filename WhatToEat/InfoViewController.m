//
//  InfoViewController.m
//  WhatToEat
//
//  Created by Creonopoulos Creon on 4/2/13.
//  Copyright (c) 2013 apt.gr. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize Background;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    Background.image = [UIImage imageNamed:@"AboutBackground.png"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//view controller is dismissed if back button is selected
- (IBAction)BackButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


//When the contact button is pressed, a mail composer view is initialized
- (IBAction)ContactButton:(id)sender {
    
    //Array with recepients email addresses
    NSArray *toRecipients = [NSArray arrayWithObject:@"ccreonopoulos@gmail.com"];
    
    //Initialize the mail compose view controller
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    
    if( mc == nil )
    {
        
        UIAlertView* alert_view = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Please create an email account on this device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert_view show];
        
        return;
        
    }
    
    mc.mailComposeDelegate = self;
    
    //set the recipients
    [mc setToRecipients:toRecipients];
    
    //present the compose mail view
    [self presentViewController:mc animated:YES completion:nil];
    
}

- (IBAction)GoToWebPage:(id)sender {
    
   
    UIAlertView *webAlert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"You are about to leave the application and open the web browser." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
    
    [webAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.myfridgefood.com"]];
    }

}

//When either the link or the globe are pressed, the user is redirected to the recipes webite.
//(Leaving the app because we don't want user to use the website and not the app)


//this method handles the actions taken in the mail composer view
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    NSString *message;
    
    //switch statmenet for the 5 cases of a mail
    switch (result)
    {
        //User selects cancel
        case MFMailComposeResultCancelled:
        {
            message = @"canceled";
            break;
        }
        //User selects cancel and save draft
        case MFMailComposeResultSaved:
        {
            message = @"saved";
            break;
        }
        //mail was sent
        case MFMailComposeResultSent:
        {
            message = @"sent";
            break;
        }
        //mail failed to be sent because no email account was found
        case MFMailComposeResultFailed:
        {   message = @"No email account found on this device";
            break;
        }
        default:
        {    message = @"error";
            break;
        }
    }
    
    //An alert view that displays a message according to the switch statement
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:message                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];

    //Once the action is done, dismiss the composer view
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
