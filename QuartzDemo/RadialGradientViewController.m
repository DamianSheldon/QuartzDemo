//
//  RadialGradientViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 26/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "RadialGradientViewController.h"
#import "RadialGradientView.h"

@interface RadialGradientViewController ()

@end

@implementation RadialGradientViewController

- (void)loadView
{
    self.view = [RadialGradientView new];
}

@end
