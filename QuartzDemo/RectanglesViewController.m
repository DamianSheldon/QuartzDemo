//
//  RectanglesViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 26/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "RectanglesViewController.h"
#import "RectanglesView.h"

@interface RectanglesViewController ()

@end

@implementation RectanglesViewController

- (void)loadView
{
    self.view = [RectanglesView new];
}

@end
