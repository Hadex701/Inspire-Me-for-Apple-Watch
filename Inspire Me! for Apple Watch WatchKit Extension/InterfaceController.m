//
//  InterfaceController.m
//  Inspire Me! for Apple Watch WatchKit Extension
//
//  Created by Emal Popal on 3/19/15.
//  Copyright (c) 2015 Emal Popal. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()


@property (weak, nonatomic) IBOutlet WKInterfaceLabel *quoteLabel;

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *authorLabel;

- (IBAction)inspireMe;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)inspireMe {
    
    //Need to update the two labels with a new quote
    
    self.authorLabel.text = @"testing";
    

}




@end



