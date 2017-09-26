//
//  PathView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 26/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "PathView.h"

@implementation PathView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef starPath = CGPathCreateMutable();
    
    CGFloat centerX = 0.5 * CGRectGetWidth(rect);
    CGFloat centerY = floor(0.33 * CGRectGetHeight(rect));
    CGFloat radius = 60;
    
    const CGAffineTransform m = CGAffineTransformIdentity;
    
    CGPathMoveToPoint(starPath, &m, centerX + 60, centerY);
    
    CGFloat theta = 2*M_PI * 2/5;
    
    for (int i = 1; i < 5; ++i) {
        CGFloat angle = i * theta;
        
        CGFloat x = radius * cos(angle);
        CGFloat y = radius * sin(angle);
        
        CGPathAddLineToPoint(starPath, &m, centerX + x, centerY + y);
    }
    
    CGPathCloseSubpath(starPath);
    
    CGContextAddPath(ctx, starPath);
    
    CGPathRelease(starPath);
    
    CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextEOFillPath(ctx);
}

@end
