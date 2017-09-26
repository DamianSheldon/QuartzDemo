//
//  PathViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 26/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "PathViewController.h"
#import "PathView.h"

@interface PathViewController ()

@end

@implementation PathViewController

- (void)loadView
{
    self.view = [PathView new];
}

@end
