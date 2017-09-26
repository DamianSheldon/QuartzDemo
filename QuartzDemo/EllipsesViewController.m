//
//  EllipsesViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 25/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "EllipsesViewController.h"
#import "EllipsesView.h"

@interface EllipsesViewController ()

@end

@implementation EllipsesViewController

- (void)loadView
{
    self.view = [EllipsesView new];
}

@end
