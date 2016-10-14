//
//  Weather.m
//  Forecaster
//
//  Created by Ross Gottschalk on 8/13/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import "Weather.h"

@implementation Weather

+(Weather *)weatherWithDictionary:(NSDictionary *)weatherDict
{
    Weather *aWeather = nil;
    if(weatherDict)
    {
        aWeather = [[Weather alloc] init];
        NSDictionary *resultsFromAPI = weatherDict[@"currently"];
        
        
        
        aWeather.summary = resultsFromAPI[@"summary"];
        aWeather.precipProbability = resultsFromAPI[@"precipProbability"];
        aWeather.temperature = resultsFromAPI[@"temperature"];
        aWeather.apparentTemperature = resultsFromAPI[@"apparentTemperature"];
        aWeather.humidity = resultsFromAPI[@"humidity"];
        aWeather.windSpeed = resultsFromAPI[@"windSpeed"];
    }
    return aWeather;
}




@end
