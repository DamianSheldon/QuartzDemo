//
//  AxialGradientView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 26/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "AxialGradientView.h"

@implementation AxialGradientView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    
    CGGradientRef myGradient;
    CGColorSpaceRef myColorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 1.0, 0.5, 0.4, 1.0,  // Start color
        0.8, 0.8, 0.3, 1.0 }; // End color
    
    myColorspace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
                                                      locations, num_locations);
    
    
    CGPoint myStartPoint, myEndPoint;
    myStartPoint.x = 0.0;
    myStartPoint.y = 0.0;
    myEndPoint.x = CGRectGetMaxX(rect);
    myEndPoint.y = CGRectGetMaxY(rect);
    CGContextDrawLinearGradient (myContext, myGradient, myStartPoint, myEndPoint, 0);
}

@end
