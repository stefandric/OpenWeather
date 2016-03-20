//
//  CityTableViewCell.h
//  OpenWeather
//
//  Created by Stefan Andric on 3/19/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityTemperature;

@end
