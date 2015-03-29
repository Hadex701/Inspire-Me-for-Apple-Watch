//
//  ViewController.h
//  Inspire Me! for Apple Watch
//
//  Created by Emal Popal on 3/18/15.
//  Copyright (c) 2015 Emal Popal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *quoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIButton *inspireMe;
@property NSInteger *currentlyAtQuote;
@property NSArray *quotes;

@end

