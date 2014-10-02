//
//  LoginViewController.m
//  OP Orange
//
//  Created by Ruud Visser on 27-09-14.
//  Copyright (c) 2014 Scrambled Apps. All rights reserved.
//

#import "LoginViewController.h"
#import "ONetworking.h"
@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *lastNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailLabel;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([[ONetworking sharedMSClient] isLoggedIn]){
        [self performSegueWithIdentifier:@"login" sender:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(id)sender {
    
    [[ONetworking sharedMSClient] getUser:self.emailLabel.text withSuccess:^(BOOL exists) {
       
        if(exists){
            [self performSegueWithIdentifier:@"login" sender:self];
        }else{
            [[ONetworking sharedMSClient] registerUser:self.emailLabel.text firstName:self.firstNameLabel.text lastName:self.lastNameLabel.text withSuccess:^{
                [self performSegueWithIdentifier:@"login" sender:self];
            }];
        }
        
    }];
    
    
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
