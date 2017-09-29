//
//  RadarView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 21/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "RadarView.h"
#import "ConicalLayer.h"

static NSString *const sRotateAnimationKey = @"sRotateAnimationKey";

@interface RadarView ()

@property (nonatomic) CABasicAnimation *rotateAnimation;

@end

@implementation RadarView

+ (Class)layerClass
{
    return [ConicalLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    self.contentMode = UIViewContentModeRedraw;
    
    [self setOpaque:NO];
    
//    NSArray *colors = @[
//                        (id)[UIColor redColor].CGColor,
//                        (id)[UIColor greenColor].CGColor,
//                        (id)[UIColor blueColor].CGColor,
//                        (id)[UIColor yellowColor].CGColor,
//                        (id)[UIColor purpleColor].CGColor,
//                        (id)[UIColor colorWithRed:232.0/255.0 green:240.0/255.0 blue:44.0/255.0 alpha:1.0].CGColor
//                        ];

    NSArray *colors = @[
                        (id)[UIColor colorWithRed:60.0/255.0 green:203.0/255.0 blue:87.0/255.0 alpha:1.0].CGColor,
                        (id)[UIColor colorWithRed:15.0/255.0 green:44.0/255.0 blue:17.0/255.0 alpha:1.0].CGColor
                        ];
    
    ConicalLayer *l = (ConicalLayer *)self.layer;
    
    l.colors = colors;

    // NOTE: Since our gradient layer is built as an image,
    // we need to scale it to match the display of the device.
    l.contentsScale = [UIScreen mainScreen].scale; // Retina
    
    self.clipsToBounds = YES;
    self.userInteractionEnabled = NO;
    
    return self;
}

- (void)layoutSubviews
{
    CGRect frame = self.frame;
    
    ConicalLayer *l = (ConicalLayer *)self.layer;
    
    l.cornerRadius = CGRectGetWidth(self.bounds) / 2;
    
    // Create a mask layer and the frame to determine what will be visible in the view.
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    // Create a path with the rectangle in it.
    int radius = ceil(CGRectGetWidth(frame) * 0.4);

    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(frame.size.width/2 - radius, frame.size.height/2 - radius, 2.0 * radius, 2.0 * radius) cornerRadius:radius];

    maskLayer.path = circlePath.CGPath;

    l.mask = maskLayer;
}


- (void)startScan
{
    [self.layer addAnimation:self.rotateAnimation forKey:sRotateAnimationKey];
}

- (void)stopScan
{
    [self.layer removeAnimationForKey:sRotateAnimationKey];
}

- (CABasicAnimation *)rotateAnimation
{
    if (!_rotateAnimation) {
        _rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        _rotateAnimation.duration = 1;
        _rotateAnimation.toValue = [NSNumber numberWithFloat:-M_PI];
        _rotateAnimation.cumulative = YES;
        _rotateAnimation.removedOnCompletion = NO; // this is to keep on animating after application pause-resume
        _rotateAnimation.repeatCount = MAXFLOAT;
    }
    return _rotateAnimation;
}

@end
