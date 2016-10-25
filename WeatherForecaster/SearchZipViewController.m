//
//  SearchZipViewController.m
//  Forecaster
//
//  Created by Ross Gottschalk on 8/13/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import "SearchZipViewController.h"

@interface SearchZipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchZipTextField;

@end

@implementation SearchZipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)searchZipTapped:(UIButton *)sender
{
    [self.delegate searchWasTyped:self.searchZipTextField.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancelTapped:(UIButton *)sender
{
   [self dismissViewControllerAnimated:YES completion:nil]; 
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
