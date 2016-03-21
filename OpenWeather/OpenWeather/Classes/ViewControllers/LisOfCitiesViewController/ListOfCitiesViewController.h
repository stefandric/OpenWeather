//
//  ListOfCitiesViewController.h
//  OpenWeather
//
//  Created by Stefan Andric on 3/19/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCityViewController.h"
#import "CityDetailsViewController.h"
#import "CityModel.h"

@interface ListOfCitiesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CityAdded>

/*!
 * @brief TableView for presenting array of cities.
 */
@property (weak, nonatomic) IBOutlet UITableView *listOfCitiesTableView;

/*!
 * @brief Array that holds cities. Mutable.
 */
@property (strong, nonatomic) NSMutableArray *citiesArray;

/*!
 * @brief Model of city that contains all needed data.
 */
@property (strong, nonatomic) CityModel *selectedCityModel;

/*!
 * @brief Pull to refresh control.
 */
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end
