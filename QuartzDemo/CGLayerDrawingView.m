//
//  CGLayerDrawingView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 28/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "CGLayerDrawingView.h"

@implementation CGLayerDrawingView


- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    myDrawFlag(ctx, &rect);
}

void myDrawFlag (CGContextRef context, CGRect *contextRect)
{
    // 1. Create a CGLayer Object Initialized with an Existing Graphics Context
    CGFloat heightOfStrip = 17;
    
    CGSize sizeOfStrip = CGSizeMake(contextRect->size.width, heightOfStrip);
    
    CGLayerRef stripLayer = CGLayerCreateWithContext(context, sizeOfStrip, NULL);
    
    CGSize sizeOfStar = CGSizeMake(160, 119);
    
    CGLayerRef starLayer = CGLayerCreateWithContext(context, sizeOfStar, NULL);
    
    // 2. Get a Graphics Context for the Layer
    CGContextRef ctxForStripLayer = CGLayerGetContext(stripLayer);
    
    CGContextRef ctxForStarLayer = CGLayerGetContext(starLayer);
    
    // 3. Draw to the CGLayer Graphics Context
    CGRect redStripRect = CGRectMake(0, 0, contextRect->size.width, heightOfStrip);
    
    CGContextSetRGBFillColor(ctxForStripLayer, 1.0, 0, 0, 1.0);
    CGContextFillRect(ctxForStripLayer, redStripRect);
    
    const CGPoint starPoints[] = {{ 5, 5},   {10, 15},
        {10, 15},  {15, 5},
        {15, 5},   {2.5, 11},
        {2.5, 11}, {16.5, 11},
        {16.5, 11},{5, 5}};
    
    CGContextSetRGBFillColor(ctxForStarLayer, 1.0, 1.0, 1.0, 1.0);
    CGContextAddLines(ctxForStarLayer, starPoints, sizeof(starPoints) / sizeof(starPoints[0]));
    CGContextFillPath(ctxForStarLayer);
    
    // 4. Draw the Layer to the Destination Graphics Context
    int numOfStrip = 13;
    
    // White background
    CGRect stripRect = CGRectMake(0, 0, contextRect->size.width, numOfStrip * heightOfStrip);
    stripRect.origin.y = 0.5 * (contextRect->size.height - stripRect.size.height);
    
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(context, stripRect);
    
    // Red strip
    int numOfRedStrip = 7;
    CGFloat redStripSpace = 2 * heightOfStrip;
    
    CGContextSaveGState(context);
    
    for (int i = 0; i < numOfRedStrip; ++i) {
        CGContextDrawLayerAtPoint(context, stripRect.origin, stripLayer);
        CGContextTranslateCTM(context, 0, redStripSpace);
    }
    
    CGContextRestoreGState(context);
    
    // Star background
    CGRect starRect = CGRectMake(0, CGRectGetMinY(stripRect), 160, 119);
    CGContextSetRGBFillColor (context, 0, 0, 0.329, 1.0);
    CGContextFillRect (context, starRect);
    
    CGFloat startX = 5.0, startY = 6.0;
    
    int j, i;
    
    CGFloat hSpacing = 26.0;
    CGFloat vSpacing = 22.0;
    
    CGContextSaveGState(context);
    
    CGContextTranslateCTM (context, startX, startY);
    
    int numOfSixStarRow = 5;
    
    for (j = 0; j < numOfSixStarRow; j++) {
        for (i = 0; i < 6; i++) {
            CGContextDrawLayerAtPoint (context, starRect.origin,
                                       starLayer);
            CGContextTranslateCTM (context, hSpacing, 0);
        }
        CGContextTranslateCTM (context, (-i*hSpacing), vSpacing);
    }
    
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, startX + hSpacing/2, // 33
                           startY + vSpacing/2);
    int numOfFiveStarRow = 4;
    
    for (j = 0; j < numOfFiveStarRow; j++) {
        for (i = 0; i < 5;  i++) {
            CGContextDrawLayerAtPoint (context, starRect.origin,
                                       starLayer);// 35
            CGContextTranslateCTM (context, hSpacing, 0);// 36
        }
        CGContextTranslateCTM (context, (-i*hSpacing), vSpacing);// 37
    }
    CGContextRestoreGState(context);
    
    CGLayerRelease(stripLayer);// 38
    CGLayerRelease(starLayer);
}

@end
