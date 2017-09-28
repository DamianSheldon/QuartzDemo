//
//  CurvesView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 28/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "CurvesView.h"

@implementation CurvesView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGFloat offsetY = 84.0;
    
    CGFloat w = 0.25 * CGRectGetWidth(rect);
    CGFloat h = 0.5 * CGRectGetHeight(rect) - offsetY;
    
    
    CGPoint cp1 = CGPointMake(w, offsetY);
    CGPoint cp2 = CGPointMake(CGRectGetMaxX(rect) - w, offsetY + h);
    
    CGPoint sp = CGPointMake(0, cp2.y);
    CGPoint ep = CGPointMake(CGRectGetMaxX(rect), offsetY);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, sp.x, sp.y);
    CGContextAddCurveToPoint(ctx, cp1.x, cp1.y, cp2.x, cp2.y, ep.x, ep.y);
    
    sp = CGPointMake(0, CGRectGetHeight(rect) - offsetY);
    ep = CGPointMake(CGRectGetMaxX(rect), sp.y);
    
    cp1 = CGPointMake(0.5 * CGRectGetWidth(rect), 0.5 * CGRectGetHeight(rect));
    
    CGContextMoveToPoint(ctx, sp.x, sp.y);
    CGContextAddQuadCurveToPoint(ctx, cp1.x, cp1.y, ep.x, ep.y);
    
    CGContextSetRGBStrokeColor(ctx, 1.0, 0, 0, 1.0);
    CGContextStrokePath(ctx);
}


@end
