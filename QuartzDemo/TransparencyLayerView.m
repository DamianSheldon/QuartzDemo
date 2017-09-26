//
//  TransparencyLayerView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 26/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "TransparencyLayerView.h"

@implementation TransparencyLayerView

void MyDrawTransparencyLayer (CGContextRef myContext, // 1
                              CGFloat wd,
                              CGFloat ht)
{
    CGSize          myShadowOffset = CGSizeMake (10, -20);// 2
    
    CGContextSetShadow (myContext, myShadowOffset, 10);   // 3
    CGContextBeginTransparencyLayer (myContext, NULL);// 4
    // Your drawing code here// 5
    CGContextSetRGBFillColor (myContext, 0, 1, 0, 1);
    CGContextFillRect (myContext, CGRectMake (wd/3+ 50,ht/2 ,wd/4,ht/4));
    CGContextSetRGBFillColor (myContext, 0, 0, 1, 1);
    CGContextFillRect (myContext, CGRectMake (wd/3-50,ht/2-100,wd/4,ht/4));
    CGContextSetRGBFillColor (myContext, 1, 0, 0, 1);
    CGContextFillRect (myContext, CGRectMake (wd/3,ht/2-50,wd/4,ht/4));
    CGContextEndTransparencyLayer (myContext);// 6
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, self.backgroundColor.CGColor);
    CGContextFillRect(ctx, rect);
    
    MyDrawTransparencyLayer(ctx, CGRectGetWidth(rect), CGRectGetHeight(rect));
}

@end
