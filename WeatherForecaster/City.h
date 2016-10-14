//
//  City.h
//  Forecaster
//
//  Created by Ross Gottschalk on 8/13/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic)NSString *cityName;
@property (nonatomic)NSString *stateInitials;


//Going to need to convert these to strings for 2nd API
@property (nonatomic)NSNumber *latNumber;
@property (nonatomic)NSNumber *longNumber;


+(City *) cityWithDictionary: (NSDictionary *) cityDict;

@end
