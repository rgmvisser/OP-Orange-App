//
//  MSNetworking.m
//  MySchool
//
//  Created by Ruud Visser on 04-08-14.
//  Copyright (c) 2014 Scrambled Apps. All rights reserved.
//

#import "ONetworking.h"
#import "Group.h"

@implementation ONetworking

+ (ONetworking *)sharedMSClient
{
    static ONetworking *_sharedMSClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedMSClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://130.233.87.107:1337"]];
    });
    
    return _sharedMSClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        
        OrangeURLString = @"http://130.233.87.107:1337";
        if([self isLoggedIn]){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            self.userId = [defaults objectForKey:@"userId"];
            self.username = [defaults objectForKey:@"username"];
        }
        //self.responseSerializer = [AFJSONResponseSerializer serializer];
        //self.requestSerializer = [AFJSONRequestSerializer serializer];
        
    }
    
    return self;
}


- (void)setLoginInformation:(NSString *)username userid:(NSNumber *)userid{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:username forKey:@"username"];
    [defaults setObject:userid forKey:@"userId"];
    [defaults synchronize];
    
}

- (BOOL)isLoggedIn
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"userId"] == nil){
        NSLog(@"No userid known");
        return NO;
    }else{
        return NO;
    }
}

- (void)getUser:(NSString *)email withSuccess:(void (^)(BOOL exists))success
{
    NSDictionary *parameters = @{
                                 @"where": [NSString stringWithFormat:@"{\"email\":\"%@\"}",email]
                                 };
    //NSString *url =
    [self GET:@"user" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        NSArray *users = responseObject;
        if([users count] > 0){
            NSDictionary *user = [users objectAtIndex:0];
            self.userId = [user objectForKey:@"id"];
            self.username = [user objectForKey:@"email"];
            [self setLoginInformation:self.username userid:self.userId];
            success(YES);
        }else{
            success(NO);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
}
- (void)registerUser:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName withSuccess:(void (^)(void))success
{
    
    NSDictionary *parameters = @{
                                 @"email": email,
                                 @"firstName" : firstName,
                                 @"lastName" : lastName
                                 };
    [self POST:@"user" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        self.userId = [responseObject objectForKey:@"id"];
        self.username = [responseObject objectForKey:@"email"];
        [self setLoginInformation:self.username userid:self.userId];
        success();
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
}

- (void)getGroups
{
  
    NSString *url = [NSString stringWithFormat:@"user/%@",self.userId];
    [self GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for(NSDictionary *groupDict in [responseObject objectForKey:@"groups"])
        {
            [self getGroup:[groupDict objectForKey:@"id"]];
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
}

- (AFHTTPRequestOperation *)getGroup:(NSNumber *)groupID
{

    
    NSString *url = [NSString stringWithFormat:@"group/%@",groupID];
    return [self GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        Group *group = [[Group alloc] init];
        [group loadDict: responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
    
}

- (void)joinGroup:(NSString *)joinCode{
    
    
    NSDictionary *parameters = @{
                                 @"uid": self.userId,
                                 @"joinCode" : joinCode
                                 };
    [self POST:@"group/join" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        [self getGroups];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
}

- (void)leaveGroup:(NSNumber *)groupID withSuccess:(void (^)(void))success
{
    NSString *url = [NSString stringWithFormat:@"group/%@/users/%@",groupID,self.userId];
    [self DELETE:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success();
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
}


@end
