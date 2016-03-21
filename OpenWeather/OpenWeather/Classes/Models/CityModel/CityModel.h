//
//  CityModel.h
//  OpenWeather
//
//  Created by Stefan Andric on 3/20/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 * @discussion Model of city that contains all needed weather data.
 */
@interface CityModel : NSObject <NSCoding>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *cityId; //string because of null/nil checking
@property (nonatomic, strong) NSString *humidity;
@property (nonatomic, strong) NSString *descriptionWeather;
@property (nonatomic, strong) NSString *currentTemperature;
@property (nonatomic, strong) NSString *temperatureMin;
@property (nonatomic, strong) NSString *temperatureMax;
@property (nonatomic, strong) NSString *weatherDescriptionId;
/*!
 * @discussion Method that parsing dictionary into object.
 */
-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
