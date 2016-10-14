//
//  APIController.m
//  Forecaster
//
//  Created by Ross Gottschalk on 8/13/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import "APIController.h"

@implementation APIController

//API controllers sourced from AlbumSearch*******************************

-(void)searchGoogleFor:(NSString *)searchTerm
{
//    NSString *googleSearchTerm = [searchTerm stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//    NSString *escapedSearchTerm = [googleSearchTerm stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=santa+cruz&components=postal_code:%@&sensor=false", searchTerm]];
    NSURLSession *session =[NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          if(error)
                                          {
                                              NSLog(@"Could not communicate to Google: %@", [error localizedDescription]);
                                          }
                                          else
                                          {
                                              NSError *parseError = nil;
                                              NSDictionary *googleResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                                              [self.delegate didReceiveAPIResults:googleResponse];
                                              NSLog(@"%@", googleResponse);
                                          }
                                      }];
    [dataTask resume];
}
//ee8204ba6a48788b511ebc002c5679a1

-(void)searchForecasterForLatitude:(NSString *)lat andLongitude:(NSString *)lng
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.forecast.io/forecast/ee8204ba6a48788b511ebc002c5679a1/%@,%@", lat, lng]];
    NSURLSession *session =[NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      if(error)
                                      {
                                          NSLog(@"Could not communicate to Forecaster.io: %@", [error localizedDescription]);
                                      }
                                      else
                                      {
                                          NSError *parseError = nil;
                                          NSDictionary *forecasterResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                                          [self.delegate didRecieveSECONDAPIResults:forecasterResponse];
                                          NSLog(@"%@", forecasterResponse);
                                      }
                                  }];
[dataTask resume];
}

@end
