//
//  ColoredPatternsView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 26/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "ColoredPatternsView.h"

@implementation ColoredPatternsView

#define H_PATTERN_SIZE 16
#define V_PATTERN_SIZE 18

void MyDrawColoredPattern (void *info, CGContextRef myContext)
{
    CGFloat subunit = 5; // the pattern cell itself is 16 by 18
    
    CGRect  myRect1 = {{0,0}, {subunit, subunit}},
    myRect2 = {{subunit, subunit}, {subunit, subunit}},
    myRect3 = {{0,subunit}, {subunit, subunit}},
    myRect4 = {{subunit,0}, {subunit, subunit}};
    
    CGContextSetRGBFillColor (myContext, 0, 0, 1, 0.5);
    CGContextFillRect (myContext, myRect1);
    CGContextSetRGBFillColor (myContext, 1, 0, 0, 0.5);
    CGContextFillRect (myContext, myRect2);
    CGContextSetRGBFillColor (myContext, 0, 1, 0, 0.5);
    CGContextFillRect (myContext, myRect3);
    CGContextSetRGBFillColor (myContext, .5, 0, .5, 0.5);
    CGContextFillRect (myContext, myRect4);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
    
    // 1. Write a Callback Function That Draws a Colored Pattern Cell
    
    // 2. Set Up the Colored Pattern Color Space
    CGColorSpaceRef patternSpace;
    
    patternSpace = CGColorSpaceCreatePattern (NULL);// 1
    CGContextSetFillColorSpace (ctx, patternSpace);// 2
    CGContextSetStrokeColorSpace(ctx, patternSpace);
    
    CGColorSpaceRelease (patternSpace);
    
    // 3. Set Up the Anatomy of the Colored Pattern
    static const    CGPatternCallbacks callbacks = {0, // 5
        &MyDrawColoredPattern,
        NULL};
    
    CGPatternRef pattern = CGPatternCreate (NULL, // 9
                               CGRectMake (0, 0, H_PATTERN_SIZE, V_PATTERN_SIZE),// 10
                               CGAffineTransformMake (1, 0, 0, 1, 0, 0),// 11
                               H_PATTERN_SIZE, // 12
                               V_PATTERN_SIZE, // 13
                               kCGPatternTilingConstantSpacing,// 14
                               true, // 15
                               &callbacks);
    
    // 4. Specify the Colored Pattern as a Fill or Stroke Pattern
    CGFloat alpha = 1;
//    CGContextSetStrokePattern(ctx, pattern, &alpha);
    
    CGContextSetFillPattern (ctx, pattern, &alpha);
    CGPatternRelease (pattern);// 18
    
    // 5. Draw With the Colored Pattern
//    CGContextStrokePath(ctx);
//    CGContextFillPath(ctx);
    CGContextFillRect (ctx, rect);
    
    CGContextRestoreGState(ctx);
}

@end
