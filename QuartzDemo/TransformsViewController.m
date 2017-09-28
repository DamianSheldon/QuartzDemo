//
//  TransformsViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 28/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "TransformsViewController.h"
#import "TransformsView.h"

@interface TransformsViewController ()

@end

@implementation TransformsViewController

- (void)loadView
{
    self.view = [TransformsView new];
}

@end
