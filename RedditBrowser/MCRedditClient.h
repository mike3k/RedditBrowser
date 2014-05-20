//
//  MCRedditClient.h
//  RedditBrowser
//
//  Created by Mike Cohen on 5/21/14.
//  Copyright (c) 2014 Mike Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface MCRedditClient : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSString *after_id;

+ (instancetype)instance;

- (void)GetFrontPageWithCompletion:(void (^)(NSArray *items))completion
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getNextPageWithCompletion:(void (^)(NSArray *items))completion
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)GetPage:(NSString*)page
     completion:(void (^)(NSArray *items))completion
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
