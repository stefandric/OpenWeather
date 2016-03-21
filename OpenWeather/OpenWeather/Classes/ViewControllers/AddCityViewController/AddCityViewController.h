//
//  AddCityViewController.h
//  OpenWeather
//
//  Created by Stefan Andric on 3/19/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"
#import "LogicHelper.h"

@protocol CityAdded <NSObject>
/*!
 * @discussion Delegate method for adding new city.
 */
-(void)cityAdded:(CityModel *)city;
@end

@interface AddCityViewController : UIViewController

/*!
 * @brief TextField for entering city name.
 */
@property (weak, nonatomic) IBOutlet UITextField *addCityTextField;

/*!
 * @brief Delegate's weak property.
 */
@property (weak, nonatomic) id<CityAdded> delegate; //needs to be weak, because of retain cycle
@end
