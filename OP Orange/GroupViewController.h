//
//  GroupViewController.h
//  OP Orange
//
//  Created by Ruud Visser on 27-09-14.
//  Copyright (c) 2014 Scrambled Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"
@interface GroupViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) Group *group;

@end
