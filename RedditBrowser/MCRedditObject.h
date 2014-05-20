//
//  MCRedditObject.h
//  RedditBrowser
//
//  Created by Mike Cohen on 5/21/14.
//  Copyright (c) 2014 Mike Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCRedditObject : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, assign) BOOL is_self;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger upvotes;
@property (nonatomic, assign) NSInteger downvotes;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger comments;
@property (nonatomic, assign) NSTimeInterval created;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *selftext;
@property (nonatomic, strong) NSString *selftext_html;

- (instancetype)initWithDictionary:(NSDictionary*)dict;

- (NSString*)subtitle;

- (void)downloadThumbnailImage:(void (^)(BOOL succeeded, UIImage *image))completionBlock;

@end
