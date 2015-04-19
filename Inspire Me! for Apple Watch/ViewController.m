//
//  ViewController.m
//  Inspire Me! for Apple Watch
//
//  Created by Emal Popal on 3/18/15.
//  Copyright (c) 2015 Emal Popal. All rights reserved.
//

#import "ViewController.h"
#import "IMQuote.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    //Load an initial quote and author - based upon where they left off
    [self newQuote];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    

}

- (void)newQuote {
    
    //load a new quote and update necessary values
    
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.emalpopal.inspireme"];
    
    self.updatedToQuote = [shared integerForKey:@"UpdatedTo"];
    
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
    
    NSString *theText = temp.quote;
    CGRect labelRect = CGRectMake(10, 50, 300, 50);
    _quoteLabel.adjustsFontSizeToFitWidth = NO;
    _quoteLabel.numberOfLines = 0;
    
    CGFloat fontSize = 30;
    while (fontSize > 0.0)
    {
        CGSize size = [theText sizeWithFont:[UIFont fontWithName:@"Verdana" size:fontSize] constrainedToSize:CGSizeMake(labelRect.size.width, 10000) lineBreakMode:UILineBreakModeWordWrap];
        
        if (size.height <= labelRect.size.height) break;
        
        fontSize -= 1.0;
    }
    
    //set font size
    _quoteLabel.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    
    //******
    
    //setting the values for quote and author
    
    _quoteLabel.text = temp.quote;
    _authorLabel.text = temp.author;
    
    //***** Code to adjust ui label for author
    
    _authorLabel.adjustsFontSizeToFitWidth = YES;
    _authorLabel.minimumFontSize = 0;
    
    //******
    
    //updating currently at
    self.currentlyAtQuote++;
    [shared setInteger:self.currentlyAtQuote forKey:@"CurrentlyAt"];
    [shared synchronize];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)inspireMeNow:(id)sender {
    
    //load a new quote
    [self newQuote];
    
}



@end
