//
//  SettingsViewController.m
//  OP Orange
//
//  Created by Ruud Visser on 27-09-14.
//  Copyright (c) 2014 Scrambled Apps. All rights reserved.
//

#import "SettingsViewController.h"
#import "User.h"
#import "ONetworking.h"
@interface SettingsViewController ()
{
    NSArray *_members;
}
@property (weak, nonatomic) IBOutlet UITextField *groupCode;
@property (weak, nonatomic) IBOutlet UITextField *limit;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.groupCode setText:[self.group.joinCode stringValue]];
    
    [self.slider setValue:[self.group.budget floatValue] animated:YES];
    [self changeSlider:self.slider];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}
- (IBAction)changeSlider:(id)sender {
    
    [self.limit setText:[NSString stringWithFormat:@"€%.f",round(self.slider.value)]];
    
}
- (IBAction)share:(id)sender {
    
    
    
}
- (IBAction)leaveGroup:(id)sender {
    
    [[ONetworking sharedMSClient] leaveGroup:self.group.groupid withSuccess:^{
        
        [Group removeFromGroup:self.group];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return [self.group.user count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"memberCell" forIndexPath:indexPath];
    User *user = [self.group.user objectAtIndex:indexPath.row];
    NSString *owner = @"";
    if([user.userId isEqualToNumber:self.group.owner]){
        owner = @"(Owner)";
    }
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@",user.description,owner]];
    return cell;
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
