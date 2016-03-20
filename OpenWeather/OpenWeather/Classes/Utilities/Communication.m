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
                       successBlock:(void (^)(NSDictionary *response))successHandler
                         errorBlock:(void (^) (NSDictionary *error))errorHandler
{
    NSString *apiKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiKey"];
     NSString *url = [NSString stringWithFormat:@"https://openweathermap.org/data/2.5/weather?q=%@&APPID=%@&units=metric", namer, apiKey];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                successHandler(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSDictionary *userInfo = [error userInfo];
                errorHandler(userInfo);
    }];
}


+(void)getAllCitiesInfoById:(NSString *)ids
               successBlock:(void (^)(NSDictionary *response))successHandler
                 errorBlock:(void (^) (NSDictionary *error))errorHandler
{
    NSString *apiKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiKey"];
    NSString *url = [NSString stringWithFormat:@"https://openweathermap.org/data/2.5/group?id=%@&units=metric&APPID=%@", ids, apiKey];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSDictionary *userInfo = [error userInfo];
        errorHandler(userInfo);
    }];
//http://api.openweathermap.org/data/2.5/group?id=524901,703448,2643743&units=metric&APPID=aaef45c6ee201be7e1aead64cd376fdc
}
@end
