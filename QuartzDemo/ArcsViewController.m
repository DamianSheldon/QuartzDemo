//
//  ArcsViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 25/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "ArcsViewController.h"
#import "ArcsView.h"

@interface ArcsViewController ()

@end

@implementation ArcsViewController

- (void)loadView
{
    self.view = [ArcsView new];
}

@end
