//
//  MCDetailViewController.m
//  RedditBrowser
//
//  Created by Mike Cohen on 5/20/14.
//  Copyright (c) 2014 Mike Cohen. All rights reserved.
//

#import "MCDetailViewController.h"
#import "MCRedditObject.h"

@interface MCDetailViewController ()
- (void)configureView;
@end

@implementation MCDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

  if (self.detailItem) {
      MCRedditObject *thing = self.detailItem;
      [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:thing.url]]];
      self.title = thing.title;
  }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
