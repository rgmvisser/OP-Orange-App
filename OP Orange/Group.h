//
//  Group.h
//  OP Orange
//
//  Created by Ruud Visser on 27-09-14.
//  Copyright (c) 2014 Scrambled Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GROUP_CHANGED @"group_changed"

@interface Group : NSObject

@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSNumber *budget;
@property (nonatomic,retain) NSNumber *owner;
@property (nonatomic,retain) NSNumber *currentStanding;
@property (nonatomic,retain) NSNumber *groupid;
@property (nonatomic,retain) NSNumber *joinCode;
@property (nonatomic, retain) NSArray *user;
@property (nonatomic, retain) NSArray *transactions;


- (void) loadDict:(NSDictionary *)dict;

+ (NSArray *)getGroups;
+ (void)removeFromGroup:(Group *)group;

@end
