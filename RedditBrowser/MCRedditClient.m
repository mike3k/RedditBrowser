//
//  MCRedditClient.m
//  RedditBrowser
//
//  Created by Mike Cohen on 5/21/14.
//  Copyright (c) 2014 Mike Cohen. All rights reserved.
//

#import "MCRedditClient.h"

static NSString *base_url = @"http://www.reddit.com/";

@implementation MCRedditClient

@synthesize manager = _manager;
@synthesize after_id = _after_id;

+ (instancetype)instance {
    static dispatch_once_t onceToken;
    static MCRedditClient *_client = nil;
    dispatch_once(&onceToken, ^{
        _client = [[MCRedditClient alloc] init];
    });
    return _client;
}

- (instancetype)init {
    if (self = [super init]) {
        _manager = [[AFHTTPRequestOperationManager alloc]
                    initWithBaseURL:[NSURL URLWithString:base_url]];
        _after_id = nil;
    }
    return self;
}

- (void)GetFrontPageWithCompletion:(void (^)(NSArray *items))completion
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [self GetPage:nil completion:completion failure:failure];
}

- (void)getNextPageWithCompletion:(void (^)(NSArray *items))completion
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [self GetPage:_after_id completion:completion failure:failure];
}

- (void)GetPage:(NSString*)page
     completion:(void (^)(NSArray *items))completion
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [_manager GET:[NSString stringWithFormat:@"%@.json", base_url]
       parameters:page?@{@"after":page}:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *data = [responseObject objectForKey:@"data"];
              _after_id = [data objectForKey:@"after"];
              NSArray *items = [data objectForKey:@"children"];
              completion(items);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              failure(operation,error);
          }
     ];
}



@end
