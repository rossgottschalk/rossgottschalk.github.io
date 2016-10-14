//
//  WeatherDetailViewController.h
//  Forecaster
//
//  Created by Ross Gottschalk on 8/13/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
#import "Weather.h"

@interface WeatherDetailViewController : UIViewController



@property (nonatomic) City *theCity;
@property (nonatomic) Weather *theWeather;
@end
