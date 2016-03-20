//
//  ListOfCitiesViewController.m
//  OpenWeather
//
//  Created by Stefan Andric on 3/19/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import "ListOfCitiesViewController.h"
#import "CityTableViewCell.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface ListOfCitiesViewController ()

@end

@implementation ListOfCitiesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"savedCities"]) {
        NSData *savedCities = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedCities"];
        self.citiesArray = [NSKeyedUnarchiver unarchiveObjectWithData:savedCities];
    }
    self.navigationItem.title = @"Favorite cities";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    cell.cityTemperature.text = [NSString stringWithFormat:@"%@°", city.currentTemperature];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"cityDetailsSegue" sender:self];
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
    [plusButton setFrame:CGRectMake(SCREEN_WIDTH-60, 30, 50, 20)];
    [plusButton setTitle:@"+" forState:UIControlStateNormal];
    [plusButton addTarget:self action:@selector(plusButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:plusButton];
    return footerView;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.citiesArray removeObjectAtIndex:indexPath.row];
        [self.listOfCitiesTableView reloadData];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.citiesArray];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"savedCities"];
    }
}
#pragma mark - PlusButton
-(void)plusButtonTapped:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"addCitySegue" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addCitySegue"]) {
        AddCityViewController *vc = [segue destinationViewController];
        vc.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"cityDetailsSegue"]) {
        __unused CityDetailsViewController *vc = [segue destinationViewController];
    }
}

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
}

@end
