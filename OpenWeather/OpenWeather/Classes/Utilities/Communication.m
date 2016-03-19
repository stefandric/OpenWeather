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

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"api.openweathermap.org/data/2.5/weather?q=%@&APPID=%@", namer, apiKey];
    NSLog(@"%@", url);
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *userInfo = [error userInfo];
        errorHandler(userInfo);
    }];
}
@end
