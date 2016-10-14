//
//  WeatherDetailViewController.m
//  Forecaster
//
//  Created by Ross Gottschalk on 8/13/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import "WeatherDetailViewController.h"

@interface WeatherDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelsLikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *chanceOfRainLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;

-(void)configureView;

@end

@implementation WeatherDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


//next two methods sourced from Greg's GitHub Friends ********************************************
-(void)setCity:(City *)specificCity andSetWeather:(Weather *)specificWeather
{
    if (self.theCity != specificCity && self.theWeather!= specificWeather)
    {
        self.theCity = specificCity;
        self.theWeather = specificWeather;
        [self configureView];
    }
}



-(void)configureView
{
    if (self.theCity && self.theWeather)
    {
        self.cityNameLabel.text = [NSString stringWithFormat:@"%@ is", self.theCity.cityName];
        
        
        self.tempLabel.text = [NSString stringWithFormat:@"%d°F",[self.theWeather.temperature intValue]];
        self.windLabel.text = [NSString stringWithFormat:@"%dmph", [self.theWeather.windSpeed intValue]];
        self.feelsLikeLabel.text = [NSString stringWithFormat:@"%d°F",[self.theWeather.apparentTemperature intValue]];
        
        
        
        
        //doubles because API gives it as a double
        //sourced from StackOverFlow****************************************************************
        self.humidityLabel.text = [NSString stringWithFormat:@"%g%%", ([self.theWeather.humidity doubleValue] * 100)];
        self.chanceOfRainLabel.text = [NSString stringWithFormat:@"%g%%", ([self.theWeather.precipProbability doubleValue] * 100)];
    }
}

- (IBAction)backPressed:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
