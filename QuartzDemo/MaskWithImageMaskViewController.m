//
//  MaskWithImageMaskViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 27/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "MaskWithImageMaskViewController.h"
#import "MaskWithImageMaskOperation.h"

@interface MaskWithImageMaskViewController ()

@property (nonatomic) UIImageView *imageView;

@end

@implementation MaskWithImageMaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    [self configureConstraintsForImageView];
    
    MaskWithImageMaskOperation *op = [MaskWithImageMaskOperation new];
    [op start];
    
    self.imageView.image = op.maskedImage;
}

- (void)configureConstraintsForImageView
{
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
}

#pragma mark - Getter

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

@end
