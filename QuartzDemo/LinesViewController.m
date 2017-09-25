//
//  LinesViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 25/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "LinesViewController.h"
#import "LinesView.h"

@interface LinesViewController ()

@end

@implementation LinesViewController

- (void)loadView
{
    self.view = [LinesView new];
}

@end
