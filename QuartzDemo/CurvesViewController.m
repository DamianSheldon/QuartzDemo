//
//  CurvesViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 28/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "CurvesViewController.h"
#import "CurvesView.h"

@interface CurvesViewController ()

@end

@implementation CurvesViewController

- (void)loadView
{
    self.view = [CurvesView new];
}

@end
