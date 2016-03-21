//
//  Communication.h
//  OpenWeather
//
//  Created by Stefan Andric on 3/19/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "CityModel.h"

@interface Communication : NSObject

/*
 @discussion Getting city info from server.
 */
+(void)getCityInformationByCityName:(NSString *)namer
                       successBlock:(void (^)(CityModel *city))successHandler
                         errorBlock:(void (^) (NSDictionary *error))errorHandler;

/*
 @discussion Getting array of cities, by their ID.
 */
+(void)getAllCitiesInfoById:(NSString *)ids
               successBlock:(void (^)(NSArray *allCities))successHandler
                 errorBlock:(void (^) (NSDictionary *error))errorHandler;
@end
