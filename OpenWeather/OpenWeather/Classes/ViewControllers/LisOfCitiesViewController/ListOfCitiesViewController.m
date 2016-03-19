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
    
    cell.cityNameLabel.text = self.citiesArray[indexPath.row];
    
    return cell;
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
}

-(void)cityAdded:(NSString *)cityName
{
    if (self.citiesArray.count) { //If there is some city, check that this
        if (![self.citiesArray containsObject:cityName]) {
            [self.citiesArray addObject:cityName];
        }
    }
    else { //Array need to allocated and initialized with object
        self.citiesArray = [[NSMutableArray alloc] initWithObjects:cityName, nil];
    }
    [self.listOfCitiesTableView reloadData]; //Refresh data with newest
}

@end
