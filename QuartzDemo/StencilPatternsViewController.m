//
//  StencilPatternsViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 26/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "StencilPatternsViewController.h"
#import "StencilPatternsView.h"

@interface StencilPatternsViewController ()

@end

@implementation StencilPatternsViewController

- (void)loadView
{
    self.view = [StencilPatternsView new];
}

@end
