//
//  MCMasterViewController.m
//  RedditBrowser
//
//  Created by Mike Cohen on 5/20/14.
//  Copyright (c) 2014 Mike Cohen. All rights reserved.
//

#import "MCMasterViewController.h"
#import "MCDetailViewController.h"

#import "MCRedditClient.h"
#import "MCRedditObject.h"

#import "SVPullToRefresh.h"

#import "MCTableViewCell.h"

#pragma mark - MCMasterViewController

@interface MCMasterViewController () {
    NSMutableArray *_objects;
    
}
@end

@implementation MCMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)updateItems:(NSArray*)items replace:(BOOL)replace {
    if (nil == _objects) {
        _objects = [NSMutableArray array];
    } else if (replace) {
        [_objects removeAllObjects];
    }
    for(NSDictionary *item in items) {
        NSDictionary *data = [item objectForKey:@"data"];
        if(nil != data) {
            MCRedditObject *thing = [[MCRedditObject alloc] initWithDictionary:data];
            [_objects addObject:thing];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)loadFirstPage {
    __weak typeof(self) weakself = self;
    [[MCRedditClient instance] GetFrontPageWithCompletion:^(NSArray *items) {
        [weakself updateItems:items replace:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error downloading page: %@",error);
    }];
}

- (void)loadNextPage {
    __weak typeof(self) weakself = self;
    [[MCRedditClient instance] getNextPageWithCompletion:^(NSArray *items) {
        [weakself updateItems:items replace:NO];
        [weakself.tableView.infiniteScrollingView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error downloading page: %@",error);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    __weak typeof(self) weakself = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakself loadFirstPage];
   }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakself loadNextPage];
    }];
    
    [self loadFirstPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    MCRedditObject *thing = _objects[indexPath.row];
    cell.textLabel.text = [thing description];
    cell.detailTextLabel.text = [thing subtitle];
    cell.imageView.image = nil;
    [cell setNeedsLayout];

    if (thing.thumbnail) {
        cell.tag = indexPath.row;
        [thing downloadThumbnailImage:^(BOOL succeeded, UIImage *image) {
            if (succeeded && cell.tag == indexPath.row) {
                cell.imageView.image = image;
                [cell setNeedsLayout];
            }
        }];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MCRedditObject *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
