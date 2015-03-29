//
//  AppDelegate.m
//  Inspire Me! for Apple Watch
//
//  Created by Emal Popal on 3/18/15.
//  Copyright (c) 2015 Emal Popal. All rights reserved.
//

#import "AppDelegate.h"
#import "IMCommunication.h"
#import "IMQuote.h"
#import "IMQuotesBuilder.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Let the device know we want to receive push notifications
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    
    [application registerForRemoteNotifications]; //allow remote payloads to be presented but no actions available
    
    //[application registerusernotificationsettings:mysettings]; in case we want to implement actions later
    


    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    
    //MyAPNSServer *myServer = //....
    //[myServer registerPushToken: deviceToken];
    
    //stripping extra chars
    
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    token = [token stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];

    NSLog(@"New Token: %@", token);
    
    //Need to check current NS user default for what quote the user is on and what quote the user has been updated to after getting or failing to get device token.
    
    self.updatedToQuote = [[NSUserDefaults standardUserDefaults] integerForKey:@"UpdatedTo"];
    
    //check the server if this device is up to date or not. If not proceed with asking for an update
    
    //Initializing an instance of the communicator class
    IMCommunication *communicationLink = [[IMCommunication alloc] init];
    
    self.communicator = communicationLink;
    self.communicator.delegate = self;
    
    BOOL result;
    
    result = [self.communicator UpdateCheck: self.updatedToQuote];
    
    if(result) {
        NSLog(@"Result is true");
        
        //Need to request an update
        
        
    }
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
    
    //Need to check current NS user default for what quote the user is on and what quote the user has been updated to after getting or failing to get device token.
    
    
    self.updatedToQuote = [[NSUserDefaults standardUserDefaults] integerForKey:@"UpdatedTo"];
    
    //check the server if this device is up to date or not. If not proceed with asking for an update
    
    //Initializing an instance of the communicator class
    IMCommunication *communicationLink = [[IMCommunication alloc] init];
    
    self.communicator = communicationLink;
    self.communicator.delegate = self;
    
    BOOL result;
    
    result = [self.communicator UpdateCheck: self.updatedToQuote];
    
    if(result) {
        NSLog(@"Result is true");
        
        //Need to request an update
        NSInteger *tester = 5;
        
        [self.communicator RequestUpdate: tester : @"nothing here"];
    }
    
    
}

#pragma mark - IMCommunicationDelegate

- (void)receivedQuotesJSON:(NSData *)objectNotation
{

    //Need to work with the data received - storing it in user defaults and also updating updatedToQuote variable
    
    NSError *error = nil;
    NSArray *quotes = [IMQuotesBuilder quotesFromJSON:objectNotation error:&error];
    
    //Now that we have our array of custom objects we need to user default it and update updated to...
    
    //archive
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:quotes ];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"quotes"];
    
    //updating the updated to
    [[NSUserDefaults standardUserDefaults] setInteger:[quotes count] forKey:@"UpdatedTo"];
    
    
    
}

- (void)fetchingQuotesFailedWithError:(NSError *)error
{

    
    
}

@end
