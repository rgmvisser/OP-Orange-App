//
//  GroupsTableViewController.m
//  OP Orange
//
//  Created by Ruud Visser on 27-09-14.
//  Copyright (c) 2014 Scrambled Apps. All rights reserved.
//

#import "GroupsTableViewController.h"
#import "ONetworking.h"
#import "Group.h"
#import "GroupViewController.h"
@interface GroupsTableViewController () <UIAlertViewDelegate>
{
    NSArray *_groups;
}

@end

@implementation GroupsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _groups = [[NSArray alloc] init];
    [[ONetworking sharedMSClient] getGroups];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Initialize Refresh Control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    // Configure Refresh Control
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    // Configure View Controller
    [self setRefreshControl:refreshControl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable:)
                                                 name:GROUP_CHANGED object:nil];
    
}

- (void)reloadTable:(id)sender
{
    _groups = [Group getGroups];
    [self.tableView reloadData];
}

- (void)refresh:(id)sender
{
    [[ONetworking sharedMSClient] getGroups];
    [(UIRefreshControl *)sender endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addGroup:(id)sender {
  
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Join group" message:@"Enter the code of the group" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Join", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    // The user created a new item, add it
    if (buttonIndex == 1) {
        // Get the input text
        NSString *joinCode = [[alertView textFieldAtIndex:0] text];
        [[ONetworking sharedMSClient] joinGroup:joinCode];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [_groups count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupCell" forIndexPath:indexPath];
    
    Group *group = [_groups objectAtIndex:indexPath.row];
    [cell.textLabel setText:group.name];
    [cell.detailTextLabel setText:[group.user componentsJoinedByString:@", "]];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UITableViewCell *cell = (UITableViewCell *)sender;
    NSIndexPath *ip = [self.tableView indexPathForCell:cell];
    NSLog(@"Index: %@",ip);
    GroupViewController *gvc = (GroupViewController *)segue.destinationViewController;
    gvc.group = [_groups objectAtIndex:ip.row];
    
}


@end
