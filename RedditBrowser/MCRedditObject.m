//
//  MCRedditObject.m
//  RedditBrowser
//
//  Created by Mike Cohen on 5/21/14.
//  Copyright (c) 2014 Mike Cohen. All rights reserved.
//

#import "MCRedditObject.h"

@implementation MCRedditObject

@synthesize id = _id;
@synthesize is_self = _is_self;
@synthesize title = _title;
@synthesize upvotes = _upvotes;
@synthesize downvotes = _downvotes;
@synthesize score = _score;
@synthesize comments = _comments;
@synthesize created = _created;
@synthesize url = _url;
@synthesize thumbnail = _thumbnail;
@synthesize selftext = _selftext;
@synthesize selftext_html = _selftext_html;

- (instancetype)initWithDictionary:(NSDictionary*)dict {
    if (self = [super init]) {
        // initialize fields from dictionary
        _id = [dict objectForKey:@"id"];
        _is_self = [[dict objectForKey:@"is_self"] integerValue];
        _title = [dict objectForKey:@"title"];
        _upvotes = [[dict objectForKey:@"ups"] integerValue];
        _downvotes = [[dict objectForKey:@"downs"] integerValue];
        _score = [[dict objectForKey:@"score"] integerValue];
        _comments = [[dict objectForKey:@"num_comments"] integerValue];
        _created = [[dict objectForKey:@"created"] floatValue];
        _url = [dict objectForKey:@"url"];
        _thumbnail = [dict objectForKey:@"thumbnail"];
        _selftext = [dict objectForKey:@"selftext"];
        _selftext_html = [dict objectForKey:@"selftext_html"];
    }
    return self;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@",_title];
}

- (NSString*)subtitle {
    return [NSString stringWithFormat:@"%d comment%@ \u21e1%d\u21e3",
            _comments, (_comments == 1) ? @"" : @"s",_score];
}

- (void)downloadThumbnailImage:(void (^)(BOOL succeeded, UIImage *image))completionBlock {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.thumbnail]]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (nil == connectionError) {
                                   UIImage *image = [UIImage imageWithData:data];
                                   completionBlock(YES,image);
                               } else {
                                   completionBlock(NO,nil);
                               }
                           }];
}


@end
