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
    self.currentlyAtQuote = [[NSUserDefaults standardUserDefaults] integerForKey:@"CurrentlyAt"];
    self.currentlyAtQuote++;
    
    //unarchive
    NSData *quotesData = [[NSUserDefaults standardUserDefaults] objectForKey:@"quotes"];
    self.quotes = (NSArray*)[NSKeyedUnarchiver unarchiveObjectWithData:quotesData];
    
    IMQuote *temp = [[IMQuote alloc] init];
    temp = [self.quotes objectAtIndex:self.currentlyAtQuote];
    
    _quoteLabel.text = temp.quote;
    
    //updating currently at
    [[NSUserDefaults standardUserDefaults] setInteger:_currentlyAtQuote forKey:@"CurrentlyAt"];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)inspireMeNow:(id)sender {
    
}



@end
