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

/*!
 * @discussion Showing alert with generic message and cancel button.
 */
+(UIAlertController *)showAlertController;

/*!
 * @discussion Checking is string nil or null
 * @return BOOL - if YES string is OK.
 */

+(BOOL)notNullOrNil:(NSString *)input;
@end
