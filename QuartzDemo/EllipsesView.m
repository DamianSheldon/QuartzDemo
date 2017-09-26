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
    
    CGFloat w = CGRectGetWidth(r), h = CGRectGetHeight(r);
    
    r.origin.x = 0.5 * (CGRectGetWidth(rect) - h);
    r.origin.y = 0.5 * (CGRectGetHeight(rect) - w);
    
    r.size.width = h;
    r.size.height = w;
    
    CGContextAddEllipseInRect(ctx, r);
    
    // How to implement this rotate with transform?
//    CGContextSaveGState(ctx);
//    
//    CGContextRotateCTM(ctx, M_PI_2);
//
//    CGContextTranslateCTM(ctx, 0.5 * (CGRectGetWidth(rect) + CGRectGetHeight(r)) , -0.5 * (CGRectGetHeight(rect) - CGRectGetHeight(r)));
//
//    CGContextAddEllipseInRect(ctx, r);
//    
//    CGContextRestoreGState(ctx);
    
    CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextStrokePath(ctx);
}

@end
