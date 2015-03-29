//
//  IMQuotesBuilder.h
//  Inspire Me! for Apple Watch
//
//  Created by Emal Popal on 3/29/15.
//  Copyright (c) 2015 Emal Popal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMQuotesBuilder : NSObject

+ (NSArray *)quotesFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
