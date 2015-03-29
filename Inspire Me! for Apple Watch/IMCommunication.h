//
//  IMCommunication.h
//  Inspire Me! for Apple Watch
//
//  Created by Emal Popal on 3/21/15.
//  Copyright (c) 2015 Emal Popal. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol IMCommunicationDelegate;

@interface IMCommunication : NSObject

//Communication messaging
@property (weak, nonatomic) id<IMCommunicationDelegate> delegate;

//test
@property (retain, nonatomic) NSMutableData *receivedData;
@property (retain, nonatomic) NSURLConnection *connection;

//need to public methods, one is an update check that returns a bool and the second is to update the device

- (id) init;
-(BOOL)UpdateCheck: (NSInteger *)currentlyAtUpdate;
-(void)RequestUpdate: (NSInteger *)currentlyAtQuote : (NSString *)myDeviceToken;

@end
