//
//  User.m
//  OP Orange
//
//  Created by Ruud Visser on 27-09-14.
//  Copyright (c) 2014 Scrambled Apps. All rights reserved.
//

#import "User.h"

@implementation User

- (void)loadDict:(NSDictionary *)dict{
    
    self.userId = [dict objectForKey:@"id"];
    self.firstName = [dict objectForKey:@"firstName"];
    self.lastName = [dict objectForKey:@"lastName"];
    self.email = [dict objectForKey:@"email"];
    
}

- (NSString *)description{
    
    return [NSString stringWithFormat:@"%@ %@",self.firstName,self.lastName];
    
}

@end
