//
//  TransformsView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 28/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "TransformsView.h"

@implementation TransformsView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(ctx);
    
    CGFloat dy = 0.25 * CGRectGetWidth(rect);
    dy = 0.5 * (CGRectGetHeight(rect) - dy);
    
    CGRect r = CGRectInset(rect, 0, dy);
    
    CGContextAddRect(ctx, r);
    CGContextAddEllipseInRect(ctx, r);
    
    CGContextSaveGState(ctx);

    CGContextRotateCTM(ctx, M_PI_2);
    
    /*
     X: - > up
     X: + > down
     
     Y: - > right
     Y: + > left
     
     translate right -(0.5 * (CGRectGetHeight(rect) - CGRectGetWidth(rect)) + CGRectGetWidth(rect))
     translate down 0.5 * (CGRectGetHeight(rect) - CGRectGetWidth(rect))
     */
    CGContextTranslateCTM(ctx, 0.5 * (CGRectGetHeight(rect) - CGRectGetWidth(rect)), -(0.5 * (CGRectGetHeight(rect) - CGRectGetWidth(rect)) + CGRectGetWidth(rect)));
    
    CGContextAddRect(ctx, r);
    CGContextAddEllipseInRect(ctx, r);

    NSLog(@"Modified CTM:%@\n", NSStringFromCGAffineTransform(CGContextGetCTM(ctx)));

    CGContextRestoreGState(ctx);
    
    CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextStrokePath(ctx);
    
    CGContextSetRGBFillColor(ctx, 1.0, 0, 0, 1.0);
    CGContextFillPath(ctx);
    
    // {a, b, c, d, tx, ty}
    NSLog(@"UIKit CTM:%@\n", NSStringFromCGAffineTransform(CGContextGetCTM(ctx)));
    
    CGContextSaveGState(ctx);
    
    CGContextTranslateCTM(ctx, 0, CGRectGetHeight(rect));
    NSLog(@"Quartz part 1 CTM:%@\n", NSStringFromCGAffineTransform(CGContextGetCTM(ctx)));

    CGContextScaleCTM(ctx, 1, -1);
    NSLog(@"Quartz CTM:%@\n", NSStringFromCGAffineTransform(CGContextGetCTM(ctx)));

    CGContextTranslateCTM(ctx, 0, CGRectGetHeight(rect));
    NSLog(@"UIKit part 1 CTM:%@\n", NSStringFromCGAffineTransform(CGContextGetCTM(ctx)));
    
    CGContextScaleCTM(ctx, 1, -1);
    NSLog(@"UIKit part 2 CTM:%@\n", NSStringFromCGAffineTransform(CGContextGetCTM(ctx)));
    
    CGContextRestoreGState(ctx);
}

@end
