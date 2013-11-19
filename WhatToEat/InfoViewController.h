//
//  InfoViewController.h
//  WhatToEat
//
//  Created by Creonopoulos Creon on 4/2/13.
//  Copyright (c) 2013 apt.gr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface InfoViewController : UIViewController <MFMailComposeViewControllerDelegate>

- (IBAction)BackButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *Background;

- (IBAction)ContactButton:(id)sender;

- (IBAction)GoToWebPage:(id)sender;

@end
