//
//  Weather.h
//  Forecaster
//
//  Created by Ross Gottschalk on 8/13/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property (nonatomic) NSString *summary;
@property (nonatomic) NSNumber *precipProbability;
@property (nonatomic) NSNumber *temperature;
@property (nonatomic) NSNumber *apparentTemperature;
@property (nonatomic) NSNumber *humidity;
@property (nonatomic) NSNumber *windSpeed;



+(Weather *) weatherWithDictionary: (NSDictionary *)weatherDict;



@end
