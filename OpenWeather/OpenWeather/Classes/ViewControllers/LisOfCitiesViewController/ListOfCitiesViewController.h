//
//  ListOfCitiesViewController.h
//  OpenWeather
//
//  Created by Stefan Andric on 3/19/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCityViewController.h"

@interface ListOfCitiesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CityAdded>

@property (weak, nonatomic) IBOutlet UITableView *listOfCitiesTableView;
@property (strong, nonatomic) NSMutableArray *citiesArray;

@end
