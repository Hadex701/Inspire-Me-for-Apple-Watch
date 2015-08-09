//
//  AppDelegate.h
//  Inspire Me! for Apple Watch
//
//  Created by Emal Popal on 3/18/15.
//  Copyright (c) 2015 Emal Popal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMCommunicationDelegate.h"
#import "IMCommunication.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, IMCommunicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property NSInteger updatedToQuote;
@property NSInteger currentlyAtQuote;
@property (strong, nonatomic) IMCommunication *communicator;

@end

