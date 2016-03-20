//
//  Communication.h
//  OpenWeather
//
//  Created by Stefan Andric on 3/19/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface Communication : NSObject
+(void)getCityInformationByCityName:(NSString *)namer
                       successBlock:(void (^)(NSDictionary *response))successHandler
                         errorBlock:(void (^) (NSDictionary *error))errorHandler;

+(void)getAllCitiesInfoById:(NSString *)ids
               successBlock:(void (^)(NSDictionary *response))successHandler
                 errorBlock:(void (^) (NSDictionary *error))errorHandler;
@end
