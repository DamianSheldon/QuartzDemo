//
//  ConicalViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 21/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "ConicalViewController.h"
#import "RadarView.h"

@interface ConicalViewController ()

@property (nonatomic) RadarView *radarView;

@end

@implementation ConicalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.radarView];
    [self configureConstraintsForRadarView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [self.radarView startScan];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [self.radarView stopScan];
}

- (void)configureConstraintsForRadarView
{
    self.radarView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.radarView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.radarView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.radarView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.radarView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.radarView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
}

#pragma mark - Getter

- (RadarView *)radarView
{
    if (!_radarView) {
        _radarView = [[RadarView alloc] initWithFrame:CGRectZero];
//        _radarView.backgroundColor = [UIColor redColor];
    }
    return _radarView;
}

@end
