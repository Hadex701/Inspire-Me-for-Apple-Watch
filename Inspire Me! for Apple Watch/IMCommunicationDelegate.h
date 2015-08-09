//
//  IMCommunicationDelegate.h
//  Inspire Me! for Apple Watch
//
//  Created by Emal Popal on 3/21/15.
//  Copyright (c) 2015 Emal Popal. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IMCommunicationDelegate
- (void)receivedQuotesJSON:(NSData *)objectNotation;
- (void)fetchingQuotesFailedWithError:(NSError *)error;
@end
