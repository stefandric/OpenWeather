//
//  CityModel.m
//  OpenWeather
//
//  Created by Stefan Andric on 3/20/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import "CityModel.h"
#import "LogicHelper.h"

@implementation CityModel

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        if ([LogicHelper notNullOrNil:[dict objectForKey:@"name"]] == YES) {
         self.name = [dict objectForKey:@"name"];
        }
        else {
            self.name = @"";
        }
        
        if ([LogicHelper notNullOrNil:[dict objectForKey:@"id"]] == YES) {
            self.cityId = [dict objectForKey:@"id"];
        }
        else {
            self.cityId = @"";
        }
        
        
        NSDictionary *main = [dict objectForKey:@"main"];
        if ([LogicHelper notNullOrNil:[main objectForKey:@"humidity"]] == YES) {
            self.humidity = [main objectForKey:@"humidity"];
        }
        else {
            self.humidity = @"";
        }
        
        NSArray *weather = [dict objectForKey:@"weather"];
        for (NSDictionary *temp in weather) {
            if ([LogicHelper notNullOrNil:[temp objectForKey:@"description"]] == YES) {
                self.descriptionWeather = [temp objectForKey:@"description"];
            }
            else {
                self.descriptionWeather = @"";
            }
            
            if ([LogicHelper notNullOrNil:[temp objectForKey:@"description"]] == YES) {
                self.weatherDescriptionId = [temp objectForKey:@"id"];
            }
            else {
                self.weatherDescriptionId = @"";
            }
            
        }
        
        if ([LogicHelper notNullOrNil:[main objectForKey:@"temp"]] == YES) {
            self.currentTemperature = [main objectForKey:@"temp"];
        }
        else {
            self.currentTemperature = @"";
        }
        
        if ([LogicHelper notNullOrNil:[main objectForKey:@"temp_max"]] == YES) {
            self.temperatureMax = [main objectForKey:@"temp_max"];
        }
        else {
            self.temperatureMax = @"";
        }
        
        if ([LogicHelper notNullOrNil:[main objectForKey:@"temp_min"]] == YES) {
            self.temperatureMin = [main objectForKey:@"temp_min"];
        }
        else {
            self.temperatureMin = @"";
        }

    }
    
    return self;
}

/*
 * This method needs to be implemented because of further saving to NSData, and then to NSUserDefaults
 */
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.cityId forKey:@"cityId"];
    [aCoder encodeObject:self.humidity forKey:@"humidity"];
    [aCoder encodeObject:self.descriptionWeather forKey:@"descriptionWeather"];
    [aCoder encodeObject:self.currentTemperature forKey:@"currentTemperature"];
    [aCoder encodeObject:self.temperatureMax forKey:@"temperatureMax"];
    [aCoder encodeObject:self.temperatureMin forKey:@"temperatureMin"];
    [aCoder encodeObject:self.weatherDescriptionId forKey:@"weatherDescriptionId"];
}

/*
 * This method needs to be implemented because of further saving to NSData, and then to NSUserDefaults
 */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.cityId = [aDecoder decodeObjectForKey:@"cityId"];
        self.humidity = [aDecoder decodeObjectForKey:@"humidity"];
        self.descriptionWeather = [aDecoder decodeObjectForKey:@"descriptionWeather"];
        self.currentTemperature = [aDecoder decodeObjectForKey:@"currentTemperature"];
        self.temperatureMax = [aDecoder decodeObjectForKey:@"temperatureMax"];
        self.temperatureMin = [aDecoder decodeObjectForKey:@"temperatureMin"];
        self.weatherDescriptionId = [aDecoder decodeObjectForKey:@"weatherDescriptionId"];
        
    }
    return self;
}
@end
