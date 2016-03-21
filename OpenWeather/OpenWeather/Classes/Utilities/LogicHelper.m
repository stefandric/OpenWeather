//
//  LogicHelper.m
//  OpenWeather
//
//  Created by Stefan Andric on 3/21/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import "LogicHelper.h"

@implementation LogicHelper

+(UIAlertController *)showAlertController
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error"
                                                                        message:@"Server side error. Please try again."
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    [controller addAction:ok];
    
    return controller;
    
}

+(BOOL)notNullOrNil:(NSString *)input
{
    if (input != (id)[NSNull null] && input!= nil) {
        return YES;
    }
    else {
        return NO;
    }
}
@end
