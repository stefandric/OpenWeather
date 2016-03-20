//
//  CityModel.m
//  OpenWeather
//
//  Created by Stefan Andric on 3/20/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.name = [dict objectForKey:@"name"];
        NSDictionary *sys = [dict objectForKey:@"sys"];
        self.cityId = [sys objectForKey:@"id"];
        NSDictionary *main = [dict objectForKey:@"main"];
        self.humidity = [main objectForKey:@"humidity"];
        NSArray *weather = [dict objectForKey:@"weather"];
        for (NSDictionary *temp in weather) {
            self.descriptionWeather = [temp objectForKey:@"description"];
        }
        self.currentTemperature = [main objectForKey:@"temp"];
        self.temperatureMax = [main objectForKey:@"temp_max"];
        self.temperatureMin = [main objectForKey:@"temp_min"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.cityId forKey:@"cityId"];
    [aCoder encodeObject:self.humidity forKey:@"humidity"];
    [aCoder encodeObject:self.descriptionWeather forKey:@"descriptionWeather"];
    [aCoder encodeObject:self.currentTemperature forKey:@"currentTemperature"];
    [aCoder encodeObject:self.temperatureMax forKey:@"temperatureMax"];
    [aCoder encodeObject:self.temperatureMin forKey:@"temperatureMin"];
}

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
        
    }
    return self;
}
@end