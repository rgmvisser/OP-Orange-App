//
//  Group.m
//  OP Orange
//
//  Created by Ruud Visser on 27-09-14.
//  Copyright (c) 2014 Scrambled Apps. All rights reserved.
//

#import "Group.h"
#import "User.h"
#import "Transaction.h"
static NSMutableArray *groups;

@implementation Group

- (void)loadDict:(NSDictionary *)dict{
    
    self.groupid = [dict objectForKey:@"id"];
    self.name = [dict objectForKey:@"name"];
    self.budget = [dict objectForKey:@"budget"];
    self.owner = [[dict objectForKey:@"owner"] objectForKey:@"id"];
    self.currentStanding = [dict objectForKey:@"currentStanding"];
    self.joinCode = [dict objectForKey:@"joinCode"];
    NSMutableArray *users = [[NSMutableArray alloc] init];
    for(NSDictionary *userDict in [dict objectForKey:@"users"]){
        
        User *user = [[User alloc] init];
        [user loadDict:userDict];
        [users addObject:user];
    }
    self.user = users;
    
    NSMutableArray *transactions = [[NSMutableArray alloc] init];
    for (NSDictionary *transactionDict in [dict objectForKey:@"transactions"]) {
        Transaction *transaction = [[Transaction alloc] init];
        [transaction loadDict:transactionDict];
        [transactions addObject:transaction];
    }
    self.transactions = transactions;
    
    if(groups == nil){
        groups = [[NSMutableArray alloc] init];
    }
    if(![groups containsObject:self])
    {
        [groups addObject:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:GROUP_CHANGED object:nil];
    }else{
        [groups removeObject:self];
        [groups addObject:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:GROUP_CHANGED object:nil];
    }
    

}

+ (NSArray *)getGroups
{
    return groups;
}

- (BOOL)isEqual:(id)object{
    Group *group = (Group *)object;
    if([group.groupid isEqualToNumber:self.groupid])
    {
        return YES;
    }else{
        return NO;
    }
}

+ (void)removeFromGroup:(Group *)group
{
    [groups removeObject:group];
    [[NSNotificationCenter defaultCenter] postNotificationName:GROUP_CHANGED object:nil];
}

@end
