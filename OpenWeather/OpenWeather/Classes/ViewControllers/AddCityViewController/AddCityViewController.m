//
//  AddCityViewController.m
//  OpenWeather
//
//  Created by Stefan Andric on 3/19/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import "AddCityViewController.h"
#import "Communication.h"
#import "MBProgressHUD.h"

@interface AddCityViewController ()

@end

@implementation AddCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ADD CITY!");
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonTapped:(id)sender
{
    if (self.addCityTextField.hasText) {
        NSString *fetchedString = [self.addCityTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""]; //If city name have more than one word, needs to remove whitespaces
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    [Communication getCityInformationByCityName:fetchedString successBlock:^(NSDictionary *response) {
        
        CityModel *cityModel = [[CityModel alloc] initWithDictionary:response];
        [self.delegate cityAdded:cityModel];
         [self dismissViewControllerAnimated:YES completion:nil];
        
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            // Do something...
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
            
        });
    } errorBlock:^(NSDictionary *error) {
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            // Do something...
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        });
    }];
    }
    
//    [self.delegate cityAdded:self.addCityTextField.text];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
