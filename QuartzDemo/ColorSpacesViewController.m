//
//  ColorSpacesViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 26/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "ColorSpacesViewController.h"
#import "ColorSpacesView.h"

@interface ColorSpacesViewController ()

@end

@implementation ColorSpacesViewController

- (void)loadView
{
    self.view = [ColorSpacesView new];
}

@end
