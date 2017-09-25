//
//  ArcsView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 25/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "ArcsView.h"

static const int sTotalArcCount = 6;

@implementation ArcsView

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
    
    CGFloat centerX = 0.5 * w;
    CGFloat centerY = 0.5 * h;
    
    CGFloat radii = MIN(w, h) * 0.5;
    radii = floor(radii / sTotalArcCount);
    
    CGFloat angle = 2*M_PI * 5 / 6;
    
    CGContextBeginPath(ctx);
    CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 1.0);

    for (int i = 1; i < sTotalArcCount; ++i) {
        CGFloat radius = i * radii;
        
        CGFloat startAngle = (i - 1) * angle;
        CGFloat endAngle = i * angle;
        
        while (startAngle > 2*M_PI) {
            startAngle -= 2*M_PI;
        }
        
        while (endAngle > 2*M_PI) {
            endAngle -= 2*M_PI;
        }
        
        CGContextAddArc(ctx, centerX, centerY, radius, startAngle, endAngle, 0);
        CGContextStrokePath(ctx);
    }
}

@end
