//
//  TransparencyLayerViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 26/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "TransparencyLayerViewController.h"
#import "TransparencyLayerView.h"

@interface TransparencyLayerViewController ()

@end

@implementation TransparencyLayerViewController

- (void)loadView
{
    self.view = [TransparencyLayerView new];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
