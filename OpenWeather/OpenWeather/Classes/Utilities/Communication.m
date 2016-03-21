//
//  Communication.m
//  OpenWeather
//
//  Created by Stefan Andric on 3/19/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import "Communication.h"

@implementation Communication

+(void)getCityInformationByCityName:(NSString *)namer
                       successBlock:(void (^)(CityModel *city))successHandler
                         errorBlock:(void (^) (NSDictionary *error))errorHandler
{
    NSString *apiKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiKey"];
    NSString *url = [NSString stringWithFormat:@"https://openweathermap.org/data/2.5/weather?q=%@&APPID=%@&units=metric", namer, apiKey];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        CityModel *cityModel = [[CityModel alloc] initWithDictionary:responseObject];
        successHandler(cityModel);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSDictionary *userInfo = [error userInfo];
        errorHandler(userInfo);
        
    }];
}

+(void)getAllCitiesInfoById:(NSString *)ids
               successBlock:(void (^)(NSArray *allCities))successHandler
                 errorBlock:(void (^) (NSDictionary *error))errorHandler
{
    NSString *apiKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiKey"];
    NSString *url = [NSString stringWithFormat:@"https://openweathermap.org/data/2.5/group?id=%@&units=metric&APPID=%@", ids, apiKey];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSArray *listOfCities = [responseObject objectForKey:@"list"];
        NSMutableArray *allCities = [NSMutableArray new];
        for (NSDictionary *dict in listOfCities) {
            CityModel *cityModel = [[CityModel alloc] initWithDictionary:dict];
            [allCities addObject:cityModel];
        }
        successHandler(allCities);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSDictionary *userInfo = [error userInfo];
        errorHandler(userInfo);
        
    }];
}
@end
