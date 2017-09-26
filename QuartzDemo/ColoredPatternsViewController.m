//
//  ColoredPatternsViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 26/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "ColoredPatternsViewController.h"
#import "ColoredPatternsView.h"

@interface ColoredPatternsViewController ()

@end

@implementation ColoredPatternsViewController

- (void)loadView
{
    self.view = [ColoredPatternsView new];
}

@end
