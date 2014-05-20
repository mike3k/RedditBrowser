//
//  MCTaableViewCell.m
//  RedditBrowser
//
//  Created by Mike Cohen on 6/9/14.
//  Copyright (c) 2014 Mike Cohen. All rights reserved.
//

#import "MCTableViewCell.h"

@implementation MCTableViewCell

static const int hPadding = 10;
static const int vPadding = 1;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.textLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        self.textLabel.numberOfLines = 2;
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.detailTextLabel.textColor = [UIColor blueColor];
        self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
        self.detailTextLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]-2];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect imageFrame = self.imageView.frame;
    if (self.imageView.image == nil) {
        imageFrame.size.width = 0;
        imageFrame.origin.x = 0;
    } else {
        imageFrame.size.width = imageFrame.size.height;
    }
    imageFrame.origin.y = (self.frame.size.height - imageFrame.size.height) / 2;
    self.imageView.frame = imageFrame;
    
    CGRect textFrame = self.textLabel.frame;
    CGFloat oldX = textFrame.origin.x;
    textFrame.origin.y = vPadding;
    textFrame.origin.x = CGRectGetMaxX(imageFrame) + hPadding;
    textFrame.size.width -= (textFrame.origin.x - oldX);
    self.textLabel.frame = textFrame;
    
    CGRect detailFrame = self.detailTextLabel.frame;
    detailFrame.origin.x = textFrame.origin.x;
    detailFrame.origin.y = self.frame.size.height - detailFrame.size.height - vPadding;
    self.detailTextLabel.frame = detailFrame;
}

@end
