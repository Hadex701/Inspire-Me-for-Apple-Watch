//
//  IMCommunication.m
//  Inspire Me! for Apple Watch
//
//  Created by Emal Popal on 3/21/15.
//  Copyright (c) 2015 Emal Popal. All rights reserved.
//

//Communication definitions
#define ServerAPILoginURL @"http://www.geccom.com/quoteme/updatecheck/"
#define ServerAPIRequestURL @"http://www.geccom.com/quoteme/requestupdate/"


#import "IMCommunication.h"
#import "IMCommunicationDelegate.h"


@implementation IMCommunication

- (id) init
{
    if (self = [super init])
    {
    }
    return self;
}

//This works, can remove the extras

-(BOOL)UpdateCheck: (NSInteger *)currentlyAtUpdate {
    
    BOOL Result;
    NSString *myParameters = [[NSString alloc]initWithString:[NSString stringWithFormat:@"UpdatedTo=%d", currentlyAtUpdate]];
    
    NSLog(@"Request for update check has begun");
    
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:ServerAPILoginURL]];
    
    NSLog(@"This is your URL: %@", url);
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myParameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //[urlRequest setValue:currentlyAtUpdate forHTTPHeaderField:@"UpdatedTo"];

    NSURLResponse *response;
    NSError *error;
    
    [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *) response;
    
    //Getting Status Code
    NSInteger statusCode = [HTTPResponse statusCode];
    NSLog(@"This is the status code: %ld", (long)statusCode);
    
    
    NSLog(@"This is your response: %@", response);
    
    //Checking cookie storage
    
    NSLog(@"Testing: %@", [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:@"http://www.geccom.com/quoteme/"]]);
    
    if (statusCode == 202) {
        Result = YES;
    } else {
        Result = NO;
    }
    
    
    return Result;
}

//Need to implement the request of update

-(void)RequestUpdate: (NSInteger *)currentlyAtQuote : (NSString *)myDeviceToken {
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    
    
    NSURL *url = [[NSURL alloc] initWithString:ServerAPIRequestURL];
    NSString *myParameters = [[NSString alloc]initWithString:[NSString stringWithFormat:@"device_id=tester2"]];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myParameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //[NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:urlRequest] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {    }];
    
    NSURLResponse *response;
    NSError *error;
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    self.connection = connection;
    
   // [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error]];
    
    
    
        NSLog(@"%@", response);
        
        if (error) {
            [self.delegate fetchingQuotesFailedWithError:error];
        } else {
        //    [self.delegate receivedQuotesJSON:data];
        }
        

    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    //Sending the data received back to the application
    
    [self.delegate receivedQuotesJSON:self.receivedData];
    
    
    
    
    
     //testing area
    //initialize convert the received data to string with UTF8 encoding
    //NSString *htmlSTR = [[NSString alloc] initWithData:self.receivedData
                                            //  encoding:NSUTF8StringEncoding];
    //NSString *htmlSTR = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@" , htmlSTR);
    //NSLog(@"%@" , self.receivedData);
    //NSUInteger len = [self.receivedData length];
    //Byte *byteData = (Byte*)malloc(len);
    //memcpy(byteData, [self.receivedData bytes], len);
    //NSLog(@"%s" , byteData);
    

}

@end
