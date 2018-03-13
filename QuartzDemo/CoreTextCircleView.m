//
//  CoreTextCircleView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 13/03/2018.
//  Copyright © 2018 Meiliang Dong. All rights reserved.
//
#import <CoreText/CoreText.h>

#import "CoreTextCircleView.h"

typedef struct GlyphArcInfo {
    CGFloat            width;
    CGFloat            angle;    // in radians
} GlyphArcInfo;

@implementation CoreTextCircleView

static void PrepareGlyphArcInfo(CTLineRef line, CFIndex glyphCount, GlyphArcInfo *glyphArcInfo)
{
    NSArray *runArray = (__bridge NSArray *)CTLineGetGlyphRuns(line);
    
    // Examine each run in the line, updating glyphOffset to track how far along the run is in terms of glyphCount.
    CFIndex glyphOffset = 0;
    for (id run in runArray) {
        CFIndex runGlyphCount = CTRunGetGlyphCount((__bridge CTRunRef)run);
        
        // Ask for the width of each glyph in turn.
        CFIndex runGlyphIndex = 0;
        for (; runGlyphIndex < runGlyphCount; runGlyphIndex++) {
            glyphArcInfo[runGlyphIndex + glyphOffset].width = CTRunGetTypographicBounds((__bridge CTRunRef)run, CFRangeMake(runGlyphIndex, 1), NULL, NULL, NULL);
        }
        
        glyphOffset += runGlyphCount;
    }
    
    double lineLength = CTLineGetTypographicBounds(line, NULL, NULL, NULL);
    
    CGFloat prevHalfWidth = glyphArcInfo[0].width / 2.0;
    glyphArcInfo[0].angle = (prevHalfWidth / lineLength) * 2 * M_PI;
    
    // Divide the arc into slices such that each one covers the distance from one glyph's center to the next.
    CFIndex lineGlyphIndex = 1;
    for (; lineGlyphIndex < glyphCount; lineGlyphIndex++) {
        CGFloat halfWidth = glyphArcInfo[lineGlyphIndex].width / 2.0;
        CGFloat prevCenterToCenter = prevHalfWidth + halfWidth;
        
        glyphArcInfo[lineGlyphIndex].angle = (prevCenterToCenter / lineLength) * 2 * M_PI;
        
        prevHalfWidth = halfWidth;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _radius = -1.0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"0123456789abcdefghijklmnopqrstuvwxyz"];
    
    // Initialize the text matrix to a known value
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    // Flipping the Default Coordinate System
    CGContextTranslateCTM(context, 0.0, CGRectGetHeight(self.frame));
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // Draw a white background
    
    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
    assert(line != NULL);
    
    CFIndex glyphCount = CTLineGetGlyphCount(line);
    if (glyphCount == 0) {
        CFRelease(line);
        return;
    }
    
    GlyphArcInfo *    glyphArcInfo = (GlyphArcInfo*)calloc(glyphCount, sizeof(GlyphArcInfo));
    PrepareGlyphArcInfo(line, glyphCount, glyphArcInfo);
    
    // Move the origin from the lower left of the view nearer to its center.
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMidX(rect), CGRectGetMidY(rect));
    
    // Stroke the arc in red for verification.
    CGContextBeginPath(context);
    CGContextAddArc(context, 0.0, 0.0, self.radius, 2 * M_PI, 0.0, 1);
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextStrokePath(context);
    
    CGPoint textPosition = CGPointMake(0.0, self.radius);
    CGContextSetTextPosition(context, textPosition.x, textPosition.y);
    
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    CFIndex runCount = CFArrayGetCount(runArray);
    
    CFIndex glyphOffset = 0;
    CFIndex runIndex = 0;
    for (; runIndex < runCount; runIndex++) {
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CFIndex runGlyphCount = CTRunGetGlyphCount(run);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        CFIndex runGlyphIndex = 0;
        for (; runGlyphIndex < runGlyphCount; runGlyphIndex++) {
            CFRange glyphRange = CFRangeMake(runGlyphIndex, 1);
            CGContextRotateCTM(context, (glyphArcInfo[runGlyphIndex + glyphOffset].angle));
            
            // Center this glyph by moving left by half its width.
            CGFloat glyphWidth = glyphArcInfo[runGlyphIndex + glyphOffset].width;
            CGFloat halfGlyphWidth = glyphWidth / 2.0;
            CGPoint positionForThisGlyph = CGPointMake(textPosition.x - halfGlyphWidth, textPosition.y);
            
            // Glyphs are positioned relative to the text position for the line, so offset text position leftwards by this glyph's width in preparation for the next glyph.
            textPosition.x -= glyphWidth;
            
            CGAffineTransform textMatrix = CTRunGetTextMatrix(run);
            textMatrix.tx = positionForThisGlyph.x;
            textMatrix.ty = positionForThisGlyph.y;
            CGContextSetTextMatrix(context, textMatrix);
            
            /*
             We need to draw the glyphs manually in this case because we are effectively applying a graphics operation by setting the context fill color. Normally we would use kCTForegroundColorAttributeName, but this does not apply as we don't know the ranges for the colors in advance, and we wanted demonstrate how to manually draw.
             */
            CGFontRef cgFont = CTFontCopyGraphicsFont(runFont, NULL);
            CGGlyph glyph;
            CGPoint position;
            
            CTRunGetGlyphs(run, glyphRange, &glyph);
            CTRunGetPositions(run, glyphRange, &position);
            
            CGContextSetFont(context, cgFont);
            CGContextSetFontSize(context, CTFontGetSize(runFont));
            CGContextSetRGBFillColor(context, 0.25, 0.25, 0.25, 0.5);
            CGContextShowGlyphsAtPositions(context, &glyph, &position, 1);
            
            CFRelease(cgFont);
        }
        
        glyphOffset += runGlyphCount;
    }
    
    CGContextRestoreGState(context);
    
    free(glyphArcInfo);
    CFRelease(line);
}

@end
