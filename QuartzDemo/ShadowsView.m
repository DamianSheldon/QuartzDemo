//
//  ShadowsView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 26/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "ShadowsView.h"

@implementation ShadowsView

void MyDrawWithShadows (CGContextRef myContext, // 1
                        CGFloat wd, CGFloat ht)
{
    CGSize          myShadowOffset = CGSizeMake (-15,  20);// 2
    CGFloat           myColorValues[] = {1, 0, 0, .6};// 3
    CGColorRef      myColor;// 4
    CGColorSpaceRef myColorSpace;// 5
    
    CGContextSaveGState(myContext);// 6
    
    CGContextSetShadow (myContext, myShadowOffset, 5); // 7
    // Your drawing code here// 8
    CGContextSetRGBFillColor (myContext, 0, 1, 0, 1);
    CGContextFillRect (myContext, CGRectMake (wd/3 + 75, ht/2 , wd/4, ht/4));
    
    myColorSpace = CGColorSpaceCreateDeviceRGB ();// 9
    myColor = CGColorCreate (myColorSpace, myColorValues);// 10
    CGContextSetShadowWithColor (myContext, myShadowOffset, 5, myColor);// 11
    // Your drawing code here// 12
    CGContextSetRGBFillColor (myContext, 0, 0, 1, 1);
    CGContextFillRect (myContext, CGRectMake (wd/3-75,ht/2-100,wd/4,ht/4));
    
    CGColorRelease (myColor);// 13
    CGColorSpaceRelease (myColorSpace); // 14
    
    CGContextRestoreGState(myContext);// 15
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, self.backgroundColor.CGColor);
    CGContextFillRect(ctx, rect);
    
    MyDrawWithShadows(ctx, CGRectGetWidth(rect), CGRectGetHeight(rect));
}


@end
