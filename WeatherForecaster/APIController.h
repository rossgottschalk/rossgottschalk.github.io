//
//  APIController.h
//  Forecaster
//
//  Created by Ross Gottschalk on 8/13/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityTableViewController.h"

@interface APIController : NSObject

@property (strong, nonatomic) id<APIControllerProtocol> delegate;

-(void)searchGoogleFor:(NSString *)searchTerm;
-(void)searchForecasterForLatitude:(NSString *)lat andLongitude:(NSString*)lng;



@end
