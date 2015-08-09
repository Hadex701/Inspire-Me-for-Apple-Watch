//
//  InterfaceController.m
//  Inspire Me! for Apple Watch WatchKit Extension
//
//  Created by Emal Popal on 3/19/15.
//  Copyright (c) 2015 Emal Popal. All rights reserved.
//

#import "InterfaceController.h"
#import "IMQuote.h"


@interface IMInterfaceController()


@property (weak, nonatomic) IBOutlet WKInterfaceLabel *quoteLabel;

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *authorLabel;

- (IBAction)inspireMe;

@property int currentlyAtQuote;
@property int updatedToQuote;
@property NSArray *quotes;

@end


@implementation IMInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.emalpopal.inspireme"];
    
    //initiating value for what the max update to is
    self.updatedToQuote = [shared integerForKey:@"UpdatedTo"];
    
    //Load an initial quote and author - based upon where they left off
    [self newQuote];
    
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)newQuote {
    
    //load a new quote and update necessary values
    
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.emalpopal.inspireme"];
    
    self.currentlyAtQuote = [shared integerForKey:@"CurrentlyAt"];
    
    
    NSLog(@"%d %d", self.currentlyAtQuote, self.updatedToQuote);
    
    if (self.currentlyAtQuote == self.updatedToQuote) {
        self.currentlyAtQuote = 0;
    }
    
    NSLog(@"%d %d", self.currentlyAtQuote, self.updatedToQuote);
    
    //unarchive
    NSData *quotesData = [shared objectForKey:@"quotes"];
    self.quotes = (NSArray*)[NSKeyedUnarchiver unarchiveObjectWithData:quotesData];
    
    IMQuote *temp = [[IMQuote alloc] init];
    temp = [self.quotes objectAtIndex:self.currentlyAtQuote];
    
    //***** Code to adjust ui label for quote
    
    //NSString *theText = temp.quote;
    //CGRect labelRect = CGRectMake(10, 50, 300, 50);
    //_quoteLabel.adjustsFontSizeToFitWidth = NO;
    //_quoteLabel.numberOfLines = 0;
    
    //CGFloat fontSize = 30;
    //while (fontSize > 0.0)
    //{
      //  CGSize size = [theText sizeWithFont:[UIFont fontWithName:@"Verdana" size:fontSize] constrainedToSize:CGSizeMake(labelRect.size.width, 10000) lineBreakMode:UILineBreakModeWordWrap];
        
      //  if (size.height <= labelRect.size.height) break;
        
     //   fontSize -= 1.0;
   // }
    
    //set font size
    //_quoteLabel.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    
    //******
    
    //setting the values for quote and author
    
    _quoteLabel.text = temp.quote;
    _authorLabel.text = temp.author;
    
    //***** Code to adjust ui label for author
    
    //_authorLabel.adjustsFontSizeToFitWidth = YES;
    //_authorLabel.minimumFontSize = 0;
    
    //******
    
    //updating currently at
    self.currentlyAtQuote++;
    [shared setInteger:self.currentlyAtQuote forKey:@"CurrentlyAt"];
    [shared synchronize];
    
}

- (IBAction)inspireMe {
    
    //load a new quote
    [self newQuote];
    

}




@end



