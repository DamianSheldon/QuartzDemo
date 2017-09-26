//
//  RectanglesView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 26/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "RectanglesView.h"

static const int sTotalRectangleCount = 6;

@implementation RectanglesView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat maxSideLength = MIN(CGRectGetWidth(rect), CGRectGetHeight(rect));
    
    CGFloat segment = maxSideLength / sTotalRectangleCount;
    
    CGFloat theta = segment * 0.5;
    
    CGContextBeginPath(ctx);
    
    for (int i = 1; i <= sTotalRectangleCount; ++i) {
        CGFloat dx = theta * i;
        
        CGRect r = CGRectInset(rect, dx, dx);
        CGContextAddRect(ctx, r);
    }
    CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextStrokePath(ctx);
}


@end
