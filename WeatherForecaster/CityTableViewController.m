//
//  CityTableViewController.m
//  Forecaster
//
//  Created by Ross Gottschalk on 8/13/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import "CityTableViewController.h"
#import "SearchZipViewController.h"
#import "APIController.h"
#import "City.h"
#import "Weather.h"
#import "WeatherDetailViewController.h"

@interface CityTableViewController ()<SearchTextFieldDelegate, APIControllerProtocol>
@property (strong, nonatomic) NSMutableArray *addedCity;
@property (strong, nonatomic) NSMutableArray *addedWeather;

@end

@implementation CityTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.addedCity = [[NSMutableArray alloc] init];
    self.addedWeather = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addedCity.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell" forIndexPath:indexPath];
    City *aCity = self.addedCity [indexPath.row];
    Weather *aWeather = self.addedWeather [indexPath.row];
    cell.textLabel.text = aCity.cityName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d°F",[aWeather.temperature intValue]];
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowDetailSegue"])
    {
        
        WeatherDetailViewController *weatherDetailVC = [segue destinationViewController];
        
        //the cell chosen
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        
        //connect the arrays to the properties declared in the DVC
        weatherDetailVC.theCity = self.addedCity [indexPath.row];
        weatherDetailVC.theWeather = self.addedWeather [indexPath.row];
    }
    
    if ([segue.identifier isEqualToString:@"SearchCitySegue"])
    {
        SearchZipViewController *searchZipVC = [segue destinationViewController];
        searchZipVC.delegate = self;
    }
}

#pragma mark - Search Text Field Delegate
-(void)searchWasTyped:(NSString *)zipCodeToLookUp;
{
    APIController *apiController = [[APIController alloc] init];
    apiController.delegate = self;
    [apiController searchGoogleFor: zipCodeToLookUp];
    [self.tableView reloadData];
}


#pragma mark - API Protocols
-(void)didReceiveAPIResults:(NSDictionary *)googleResponse
{
    City *aCity = [City cityWithDictionary:googleResponse];
    [self.addedCity addObject:aCity];
    dispatch_async(dispatch_get_main_queue(),^{
    });
    ///self.tableview????
    //dont need it here because I just want to reload the data at the very end
    
    
    
    if(aCity)
    {
        
        //have to convert the numbers into strings
        //sourced from StackOverflow*********************************************
        NSString *latitudeForecaster = [NSString stringWithFormat:@"%@", aCity.latNumber];
        NSString *longitudeForecaster = [NSString stringWithFormat:@"%@",aCity.longNumber];
        
        //api call for second api
        APIController *apiController = [[APIController alloc] init];
        apiController.delegate = self;
        [apiController searchForecasterForLatitude:latitudeForecaster andLongitude:longitudeForecaster];
    }
}


-(void)didRecieveSECONDAPIResults:(NSDictionary *)forecastResponse;
{
    Weather *aWeather = [Weather weatherWithDictionary:forecastResponse];
    [self.addedWeather addObject:aWeather];
    dispatch_async(dispatch_get_main_queue(),^{
        [self.tableView reloadData];
    });
}

@end
