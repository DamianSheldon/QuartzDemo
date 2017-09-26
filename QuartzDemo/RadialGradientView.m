//
//  RadialGradientView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 26/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "RadialGradientView.h"

@implementation RadialGradientView

static void  myCalculateShadingValues (void *info,
                                       const CGFloat *in,
                                       CGFloat *out)
{
    size_t k, components;
    double frequency[4] = { 55, 220, 110, 0 };
    components = (size_t)info;
    for (k = 0; k < components - 1; k++)
        *out++ = (1 + sin(*in * frequency[k]))/2;
    *out++ = 1; // alpha
}

static CGFunctionRef myShadingCreateFunction (CGColorSpaceRef colorspace)// 1
{
    size_t numComponents;
    static const CGFloat input_value_range [2] = { 0, 1 };
    static const CGFloat output_value_ranges [8] = { 0, 1, 0, 1, 0, 1, 0, 1 };
    static const CGFunctionCallbacks callbacks = { 0,// 2
        &myCalculateShadingValues,
        NULL };
    
    numComponents = 1 + CGColorSpaceGetNumberOfComponents (colorspace);// 3
    return CGFunctionCreate ((void *) numComponents, // 4
                             1, // 5
                             input_value_range, // 6
                             numComponents, // 7
                             output_value_ranges, // 8
                             &callbacks);// 9
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    
    // 1. Set Up a CGFunction Object to Compute Color Values.
    // 2. Create a CGShading Object for a Radial Gradient
    CGPoint startPoint, endPoint;
    CGFloat startRadius, endRadius;
    
    startPoint = CGPointMake(0,CGRectGetMaxY(rect));
    startRadius = 10;
    endPoint = CGPointMake(CGRectGetMaxX(rect),100);
    endRadius = 60;
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFunctionRef myShadingFunction = myShadingCreateFunction (colorspace);
    CGShadingRef shading = CGShadingCreateRadial (colorspace,
                           startPoint,
                           startRadius,
                           endPoint,
                           endRadius,
                           myShadingFunction,
                           false,
                           false);
    
    // 3. Paint a Radial Gradient Using a CGShading Object
    CGContextDrawShading (myContext, shading);
    
    // 4. Release Objects
    CGShadingRelease (shading);
    CGColorSpaceRelease (colorspace);
    CGFunctionRelease (myShadingFunction);
}

@end
