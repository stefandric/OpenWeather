//
//  ListOfCitiesViewController.m
//  OpenWeather
//
//  Created by Stefan Andric on 3/19/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import "ListOfCitiesViewController.h"
#import "CityTableViewCell.h"
#import "Communication.h"
#import "MBProgressHUD.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface ListOfCitiesViewController ()

@end

@implementation ListOfCitiesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //If there is saved array in preferences, load it.
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"savedCities"]) {
        NSData *savedCities = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedCities"];
        self.citiesArray = [NSKeyedUnarchiver unarchiveObjectWithData:savedCities];
    }
    
    self.navigationItem.title = @"Favorite cities";
    self.listOfCitiesTableView.backgroundColor = [UIColor clearColor];
    
    //Setting UITableView's refreshing control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor grayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getLatestWeatherChanges)
                  forControlEvents:UIControlEventValueChanged];
    [self.listOfCitiesTableView addSubview:self.refreshControl];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.citiesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityTableViewCell *cell = (CityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cityCell"];
    CityModel *city = self.citiesArray[indexPath.row];
    cell.cityNameLabel.text = city.name;
    cell.cityTemperature.text = [NSString stringWithFormat:@"%ld°", (long)[city.currentTemperature integerValue]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    CityModel *tempModel = self.citiesArray[indexPath.row]; //Just to get name of selected model
    
    NSString *fetchedString = [tempModel.name stringByReplacingOccurrencesOfString:@" " withString:@""]; //Possible spaces in city name
    
    [Communication getCityInformationByCityName:fetchedString successBlock:^(CityModel *city) {
        
        self.selectedCityModel = city; //Prepare model for segue, so it is visible globally in this class
        [self.citiesArray replaceObjectAtIndex:indexPath.row withObject:city]; //Replace existing object with newest data.
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.citiesArray]; //Save to user defaults freshly data
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"savedCities"];
        [[NSUserDefaults standardUserDefaults] synchronize]; //Just to be sure that it is immediately changed
        
        [self performSegueWithIdentifier:@"cityDetailsSegue" sender:self];
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
            
        });
        [self.listOfCitiesTableView reloadData];
        
    } errorBlock:^(NSDictionary *error) {
        //Presenting generic error message.
        [self presentViewController:[LogicHelper showAlertController] animated:YES completion:nil];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            // Do something...
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        });
        
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    //Defining CGRect of footer view
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeSystem];
    //Setting position to bottom right
    plusButton.frame = CGRectMake(SCREEN_WIDTH/2-25, 0, 50, 50);
    UIImage *plusImage = [UIImage imageNamed:@"plusImage"];
    plusImage = [plusImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [plusButton setImage:plusImage forState:UIControlStateNormal];
    [plusButton addTarget:self action:@selector(plusButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:plusButton];
    return footerView;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Delete desired array member.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.citiesArray removeObjectAtIndex:indexPath.row];
        [self.listOfCitiesTableView reloadData];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.citiesArray];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"savedCities"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark - PlusButton

-(void)plusButtonTapped:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"addCitySegue" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addCitySegue"]) {
        AddCityViewController *vc = [segue destinationViewController];
        vc.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"cityDetailsSegue"]) {
        CityDetailsViewController *vc = [segue destinationViewController];
        vc.cityModel = self.selectedCityModel;
    }
}

#pragma mark - Utilities

-(void)cityAdded:(CityModel *)city
{
    NSMutableArray *citesNames = [NSMutableArray new];
    
    if (self.citiesArray.count) { //If there is some city
        for (CityModel *cityTemp in self.citiesArray) {
            [citesNames addObject:cityTemp.name];
        }
        if (![citesNames containsObject:city.name]) {
            [self.citiesArray addObject:city];
        }
    }
    
    else { //Array need to allocated and initialized with object
        self.citiesArray = [[NSMutableArray alloc] initWithObjects:city, nil];
    }
    
    [self.listOfCitiesTableView reloadData]; //Refresh data with newest
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.citiesArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"savedCities"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*!
 * @discussion Getting all ID's in purpose of webservice request.
 * @return String divided by comma.
 */
-(NSString *)getAllCitiesIds
{
    NSString *idsString;
    
    for (int i=0; i<self.citiesArray.count; i++) {
        CityModel *cityModel = self.citiesArray[i];
        if (i == 0) {
            idsString = cityModel.cityId; //First member is clean id.
        }
        else if (i==self.citiesArray.count-1){ //Last member without comma at the end.
            idsString = [NSString stringWithFormat:@"%@,%@", idsString, cityModel.cityId];
        }
        else {
            idsString = [NSString stringWithFormat:@"%@,%@",idsString, cityModel.cityId]; //Set the comma between all other members.
        }
    }
    return idsString;
}

/*!
 * @discussion Triggered on pull to refresh, getting last informations about cities.
 */
-(void)getLatestWeatherChanges
{
    [Communication getAllCitiesInfoById:[self getAllCitiesIds] successBlock:^(NSArray *allCities) {
        
        self.citiesArray = [NSMutableArray arrayWithArray:allCities]; //Emptying array
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.citiesArray];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"savedCities"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.listOfCitiesTableView reloadData];
        [self.refreshControl endRefreshing];
        
    } errorBlock:^(NSDictionary *error) {
       [self presentViewController:[LogicHelper showAlertController] animated:YES completion:nil]; 
    }];
    
    
}

@end
