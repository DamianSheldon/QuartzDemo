//
//  ShadowsViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 26/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "ShadowsViewController.h"
#import "ShadowsView.h"

@interface ShadowsViewController ()

@end

@implementation ShadowsViewController

- (void)loadView
{
    self.view = [ShadowsView new];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
