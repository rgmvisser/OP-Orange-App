//
//  Transaction.m
//  OP Orange
//
//  Created by Ruud Visser on 27-09-14.
//  Copyright (c) 2014 Scrambled Apps. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction

- (void)loadDict:(NSDictionary *)dict{
    
    self.transactionid = [dict objectForKey:@"id"];
    self.recipientName = [dict objectForKey:@"recipientName"];
    self.dateTime = [Transaction dateFromString:[dict objectForKey:@"createdAt"]];
    self.amount = [dict objectForKey:@"amount"];
    
}

- (NSString *)getDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMMM YYYY HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:self.dateTime];
    return dateString;
    
}

+ (NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *date = [[NSDate alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    // Always use this locale when parsing fixed format date strings
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:posix];
    date = [dateFormatter dateFromString:dateString];
    return date;
}


@end
