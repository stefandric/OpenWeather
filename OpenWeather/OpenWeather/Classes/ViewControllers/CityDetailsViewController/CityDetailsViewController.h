//
//  CityDetailsViewController.h
//  OpenWeather
//
//  Created by Stefan Andric on 3/20/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"

@interface CityDetailsViewController : UIViewController
@property (nonatomic, strong) CityModel *cityModel;

/*!
 * @brief Background image, changing depending on weather conditions.
 */
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

/*!
 * @brief Label for presenting temperature.
 */
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

/*!
 * @brief Label for presenting city name.
 */
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;

/*!
 * @brief Label for presenting humidity.
 */
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;

/*!
 * @brief Label for presenting description.
 */
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@end
