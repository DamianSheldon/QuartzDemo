//
//  MaskWithClipViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 27/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "MaskWithClipViewController.h"
#import "MaskWithClipView.h"

@interface MaskWithClipViewController ()

@end

@implementation MaskWithClipViewController

- (void)loadView
{
    self.view = [MaskWithClipView new];
}

@end
