//
//  MCDetailViewController.h
//  RedditBrowser
//
//  Created by Mike Cohen on 5/20/14.
//  Copyright (c) 2014 Mike Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCDetailViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
