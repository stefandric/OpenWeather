//
//  LogicHelper.h
//  OpenWeather
//
//  Created by Stefan Andric on 3/21/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LogicHelper : NSObject
+(UIAlertController *)showAlertController;
+(BOOL)notNullOrNil:(NSString *)input;
@end
