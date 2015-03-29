//
//  IMQuote.m
//  Inspire Me! for Apple Watch
//
//  Created by Emal Popal on 3/29/15.
//  Copyright (c) 2015 Emal Popal. All rights reserved.
//

#import "IMQuote.h"

@implementation IMQuote

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.quote = [decoder decodeObjectForKey:@"quote"];
        self.author = [decoder decodeObjectForKey:@"author"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_quote forKey:@"quote"];
    [encoder encodeObject:_author forKey:@"author"];
}

@end
