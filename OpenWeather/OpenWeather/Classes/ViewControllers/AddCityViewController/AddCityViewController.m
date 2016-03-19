//
//  AddCityViewController.m
//  OpenWeather
//
//  Created by Stefan Andric on 3/19/16.
//  Copyright © 2016 Stefan Andric. All rights reserved.
//

#import "AddCityViewController.h"
#import "Communication.h"

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
        
    
    [Communication getCityInformationByCityName:self.addCityTextField.text successBlock:^(NSDictionary *response) {
        
    } errorBlock:^(NSDictionary *error) {
        
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
