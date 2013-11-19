//
//  AppDelegate.m
//  WhatToEat
//
//  Created by Creonopoulos Creon on 3/29/13.
//  Copyright (c) 2013 apt.gr. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize favoritesArr,defaults;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //Getting the save state of the favorites array
    defaults = [NSUserDefaults standardUserDefaults];
    
    //if the saved array was null, a new array is allocated
    if([defaults objectForKey:@"FavoritesArray"] == nil)
    {
        favoritesArr = [[NSMutableArray alloc] init];

    }
    //If not, the favorites array is populated with the saved information
    else
    {
     favoritesArr = [NSMutableArray arrayWithArray:[defaults objectForKey:@"FavoritesArray"]];
    }
    [self.window setTintColor:[UIColor blackColor]];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    //Saving the favorites array
    [defaults setObject:self.favoritesArr forKey:@"FavoritesArray"];
    [defaults synchronize];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //Saving the favorites array
    [defaults setObject:self.favoritesArr forKey:@"FavoritesArray"];
    [defaults synchronize];
    
}

@end
