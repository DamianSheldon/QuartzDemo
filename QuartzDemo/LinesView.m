//
//  LinesView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 25/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "LinesView.h"

static const int sTotalLineCount = 12;

@implementation LinesView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // Transform UIKit coordinate system to Quartz 2D coordinate system
    CGFloat w = CGRectGetWidth(rect);
    CGFloat h = CGRectGetHeight(rect);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, 0, h);
    CGContextScaleCTM(ctx, 1, -1);
    
    CGFloat radii = MIN(w, h) * 0.5;
    radii = floor(radii / sTotalLineCount);
    
    CGFloat theta = 2*M_PI/ sTotalLineCount;
    
    CGFloat centerX = 0.5 * w;
    CGFloat centerY = 0.5 * h;
    
    CGContextBeginPath(ctx);
    
    for (int i = 1; i <= sTotalLineCount; ++i) {
        CGFloat alpha = i * theta;
        
        CGFloat r = i * radii;
        
        CGFloat x = centerX + r * sin(alpha);
        CGFloat y = centerY + r * cos(alpha);
        
        CGContextMoveToPoint(ctx, centerX, centerY);
        CGContextAddLineToPoint(ctx, x, y);
    }
    
    CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextStrokePath(ctx);
}


@end
