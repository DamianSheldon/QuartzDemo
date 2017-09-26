//
//  StencilPatternsView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 26/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "StencilPatternsView.h"

@implementation StencilPatternsView

#define PSIZE 16    // size of the pattern cell

static void MyDrawStencilStar (void *info, CGContextRef myContext)
{
    int k;
    double r, theta;
    
    r = 0.8 * PSIZE / 2;
    theta = 2 * M_PI * (2.0 / 5.0); // 144 degrees
    
    CGContextTranslateCTM (myContext, PSIZE/2, PSIZE/2);
    
    CGContextMoveToPoint(myContext, 0, r);
    for (k = 1; k < 5; k++) {
        CGContextAddLineToPoint (myContext,
                                 r * sin(k * theta),
                                 r * cos(k * theta));
    }
    CGContextClosePath(myContext);
    CGContextFillPath(myContext);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    
    // 1. Write a Callback Function That Draws a Stencil Pattern Cell
    // 2. Set Up the Stencil Pattern Color Space
    CGPatternRef pattern;
    CGColorSpaceRef baseSpace;
    CGColorSpaceRef patternSpace;
    
    baseSpace = CGColorSpaceCreateWithName (kCGColorSpaceGenericRGB);// 1
    patternSpace = CGColorSpaceCreatePattern (baseSpace);// 2
    CGContextSetFillColorSpace (myContext, patternSpace);// 3
    CGColorSpaceRelease(patternSpace);// 4
    CGColorSpaceRelease(baseSpace);
    
    static const CGFloat color[4] = { 0, 1, 0, 1 };// 1
    static const CGPatternCallbacks callbacks = {0, &MyDrawStencilStar, NULL};
    
    // 3. Set Up the Anatomy of the Stencil Pattern
    pattern = CGPatternCreate(NULL, CGRectMake(0, 0, PSIZE, PSIZE),// 6
                              CGAffineTransformIdentity, PSIZE, PSIZE,
                              kCGPatternTilingConstantSpacing,
                              false, &callbacks);
    
    // 4. Specify the Stencil Pattern as a Fill or Stroke Pattern
    CGContextSetFillPattern (myContext, pattern, color);
    CGPatternRelease (pattern);// 8
    
    // 5. Drawing with the Stencil Pattern
    
    CGContextFillRect (myContext,CGRectMake (0,0,PSIZE*20,PSIZE*20));
}

@end
