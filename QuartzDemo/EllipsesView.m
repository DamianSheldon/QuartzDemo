//
//  EllipsesView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 25/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "EllipsesView.h"

@implementation EllipsesView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextBeginPath(ctx);
    
    CGFloat dy = 0.25 * CGRectGetWidth(rect);
    dy = 0.5 * (CGRectGetHeight(rect) - dy);
    
    CGRect r = CGRectInset(rect, 0, dy);
    
    CGContextAddEllipseInRect(ctx, r);
    
    // Implement 90 rotate of ellipse with transform
    CGContextSaveGState(ctx);
    
    CGContextRotateCTM(ctx, M_PI_2);

    CGContextTranslateCTM(ctx, 0.5 * (CGRectGetHeight(rect) - CGRectGetWidth(rect)), -(0.5 * (CGRectGetHeight(rect) - CGRectGetWidth(rect)) + CGRectGetWidth(rect)));
    
    CGContextAddEllipseInRect(ctx, r);
    
    CGContextRestoreGState(ctx);
    
    CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextStrokePath(ctx);
}

@end
