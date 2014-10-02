//
//  GroupViewController.m
//  OP Orange
//
//  Created by Ruud Visser on 27-09-14.
//  Copyright (c) 2014 Scrambled Apps. All rights reserved.
//

#import "GroupViewController.h"
#import "SettingsViewController.h"
#import "Transaction.h"
@interface GroupViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *currentExpense;
@property (weak, nonatomic) IBOutlet UILabel *expenseLeft;

@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:self.group.name];
    
    float left = [self.group.budget floatValue] - [self.group.currentStanding floatValue];
    [self.currentExpense setText:[NSString stringWithFormat:@"€%@",self.group.currentStanding]];
    [self.expenseLeft setText:[NSString stringWithFormat:@"€%.02f",left]];
    
    
    [self.progress setProgress:0];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 5.0f);
    self.progress.transform = transform;
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    float progress = [self.group.currentStanding floatValue] / [self.group.budget floatValue];
    [self.progress setProgress:progress animated:YES];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return [self.group.transactions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"transactionCell" forIndexPath:indexPath];
    
    Transaction *transaction = [self.group.transactions objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ (%@)",transaction.recipientName,[transaction getDate]]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"€%.02f",[transaction.amount floatValue]]];
    
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    SettingsViewController *svc = (SettingsViewController *)segue.destinationViewController;
    svc.group = self.group;
    
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
