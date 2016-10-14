//
//  CityTableViewController.h
//  Forecaster
//
//  Created by Ross Gottschalk on 8/13/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SearchTextFieldDelegate
-(void)searchWasTyped:(NSString *)zipCodeToLookUp;
@end


@protocol APIControllerProtocol
-(void)didReceiveAPIResults:(NSDictionary *)googleResponse;
-(void)didRecieveSECONDAPIResults:(NSDictionary *) forecastResponse;
@end


@interface CityTableViewController : UITableViewController
@end
