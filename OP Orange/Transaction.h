//
//  Transaction.h
//  OP Orange
//
//  Created by Ruud Visser on 27-09-14.
//  Copyright (c) 2014 Scrambled Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject

@property (nonatomic,retain) NSNumber *transactionid;
@property (nonatomic,retain) NSString *recipientName;
@property (nonatomic,retain) NSDate *dateTime;
@property (nonatomic, retain) NSNumber *amount;

- (void)loadDict:(NSDictionary *)dict;
- (NSString *)getDate;
@end
