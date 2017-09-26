//
//  ColorSpacesView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 26/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "ColorSpacesView.h"

@implementation ColorSpacesView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat dy = 0.5 * (CGRectGetHeight(rect) - CGRectGetWidth(rect));
    
    CGRect outRect = CGRectInset(rect, 0, dy);
    
    CGContextSaveGState(ctx);
    
    CGContextAddRect(ctx, outRect);
    CGContextSetRGBFillColor(ctx, 1.0, 0, 0, 1.0);
    CGContextFillPath(ctx);
    
    CGContextRestoreGState(ctx);
    
    CGFloat sideLength = 0.5 * CGRectGetWidth(rect);
    CGFloat dx = 0.5 * sideLength;
    dy = 0.5 * (CGRectGetHeight(rect) - sideLength);
    
    CGRect innerRect = CGRectInset(rect, dx, dy);
    
    CGContextSaveGState(ctx);

    CGContextAddRect(ctx, innerRect);
    
    CGContextSetCMYKFillColor(ctx, 1.0, 0, 0, 0, 1.0);
    CGContextFillPath(ctx);
    
    CGContextRestoreGState(ctx);
}

@end
