//
//  AddCityViewController.h
//  OpenWeather
//
//  Created by Stefan Andric on 3/19/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityAdded <NSObject>
-(void)cityAdded:(NSString *)cityName;
@end

@interface AddCityViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *addCityTextField;
@property (weak, nonatomic) id<CityAdded> delegate; //needs to be weak, because of retain cycle
@end
