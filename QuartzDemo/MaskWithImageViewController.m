//
//  MaskWithImageViewController.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 27/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "MaskWithImageViewController.h"
#import "MaskWithImageOperation.h"

@interface MaskWithImageViewController ()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) NSOperationQueue *operationQueue;

@end

@implementation MaskWithImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    [self configureConstraintsForImageView];
    
    MaskWithImageOperation *op = [MaskWithImageOperation new];
    __weak typeof(op) weakOp = op;
    
    op.completionBlock = ^{
        __strong typeof(weakOp) strongOp = weakOp;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = strongOp.maskedImage;
        });
    };
    
    [self.operationQueue addOperation:op];
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

- (NSOperationQueue *)operationQueue
{
    if (!_operationQueue) {
        _operationQueue = [NSOperationQueue new];
    }
    return _operationQueue;
}

@end
