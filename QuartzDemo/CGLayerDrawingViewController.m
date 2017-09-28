//
//  CGLayerDrawingViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 28/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "CGLayerDrawingViewController.h"
#import "CGLayerDrawingView.h"

@interface CGLayerDrawingViewController ()

@end

@implementation CGLayerDrawingViewController

- (void)loadView
{
    self.view = [CGLayerDrawingView new];
}

@end
