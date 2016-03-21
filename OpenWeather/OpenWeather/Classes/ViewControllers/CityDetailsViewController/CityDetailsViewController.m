//
//  CityDetailsViewController.m
//  OpenWeather
//
//  Created by Stefan Andric on 3/20/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import "CityDetailsViewController.h"

@interface CityDetailsViewController ()

@end

@implementation CityDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeViewData];
    [self setBackgrounImageDependingOnDescription:self.cityModel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializeViewData
{
    self.temperatureLabel.text = [NSString stringWithFormat:@"%ld°", (long)self.cityModel.currentTemperature.integerValue];
    self.cityNameLabel.text = self.cityModel.name;
    self.humidityLabel.text = [NSString stringWithFormat:@"Humidity: %ld", (long)self.cityModel.humidity.integerValue];
    self.descriptionLabel.text = self.cityModel.descriptionWeather;

}

-(void)setBackgrounImageDependingOnDescription:(CityModel *)cityModel
{
    NSInteger weatherId = cityModel.weatherDescriptionId.integerValue;
    
    if (weatherId >=200 && weatherId<=232) {
        self.backgroundImage.image = [UIImage imageNamed:@"thunder"];
    }
    
    else if (weatherId >=300 && weatherId<=531) {
        self.backgroundImage.image = [UIImage imageNamed:@"rain"];
    }
    
    else if (weatherId >=600 && weatherId<=622) {
        self.backgroundImage.image = [UIImage imageNamed:@"snow"];
    }
    
    else {
        self.backgroundImage.image = [UIImage imageNamed:@"clearSky"];
    }
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
