//
//  IMQuotesBuilder.m
//  Inspire Me! for Apple Watch
//
//  Created by Emal Popal on 3/29/15.
//  Copyright (c) 2015 Emal Popal. All rights reserved.
//

#import "IMQuotesBuilder.h"
#import "IMQuote.h"

@implementation IMQuotesBuilder

+ (NSArray *)quotesFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    
    NSMutableArray *quotes = [[NSMutableArray alloc] init];
    

     //In this for each loop, I am taking the value of each array item and storing it in an nsdictionary - then i am updating my custom object with the values from that dictionary - Then adding it to an array to return
    
            for (NSString *key in parsedObject) {
                IMQuote *quote = [[IMQuote alloc] init];
                NSDictionary *indQuotes = [[NSDictionary alloc] init];
            

                indQuotes = [parsedObject valueForKey:key];
                NSLog(@"%@", indQuotes);
                
                
                quote.quote = [indQuotes valueForKey:@"quote"];
                quote.author = [indQuotes valueForKey:@"author"];
                
            
            [quotes addObject:quote];
            
            }
    
    return quotes;
}


@end
