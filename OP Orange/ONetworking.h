//
//  MSNetworking.h
//  MySchool
//
//  Created by Ruud Visser on 04-08-14.
//  Copyright (c) 2014 Scrambeld Apps. All rights reserved.
//

#import "AFNetworking/AFNetworking.h"
#import "AppDelegate.h"
static NSString *OrangeURLString;

@interface ONetworking : AFHTTPRequestOperationManager

@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSNumber *userId;

+ (ONetworking *)sharedMSClient;
- (instancetype)initWithBaseURL:(NSURL *)url;

- (BOOL)isLoggedIn;

- (void)getUser:(NSString *)email withSuccess:(void (^)(BOOL exists))success;
- (void)registerUser:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName withSuccess:(void (^)(void))success;

- (void)getGroups;

- (void)joinGroup:(NSString *)joinCode;

- (void)leaveGroup:(NSNumber *)groupID withSuccess:(void (^)(void))success;

@end
