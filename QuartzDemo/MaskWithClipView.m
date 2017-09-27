//
//  MaskWithClipView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 27/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "MaskWithClipView.h"

//#define CLIPPING_THE_CONTENT_WITH_AN_IMAGE

@import ImageIO;

@implementation MaskWithClipView

#ifdef CLIPPING_THE_CONTENT_WITH_AN_IMAGE
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // Get the URL to the bundle resource.
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    
    CFStringRef name = CFStringCreateWithCString (NULL, "the_mask", kCFStringEncodingUTF8);
    
    CFURLRef url = CFBundleCopyResourceURL(mainBundle, name, CFSTR("gif"), NULL);
    
    CFRelease(name);
    
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL(url, NULL);
    
    CFRelease(url);
    
    CGImageRef theMask = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
    
    CFRelease(imageSource);
    
    CGFloat halfWidth = 0.5 * CGRectGetWidth(rect);
    CGRect r = CGRectMake(halfWidth, 0, halfWidth, CGRectGetHeight(rect));
    
    CGContextClipToMask(ctx, r, theMask);
    
    CFURLRef urlOfTwoTiger = CFBundleCopyResourceURL(mainBundle, CFSTR("two_tigers"), CFSTR("gif"), NULL);
    
    CGImageSourceRef isrc = CGImageSourceCreateWithURL(urlOfTwoTiger, NULL);
    
    CFRelease(urlOfTwoTiger);
    
    CGImageRef twoTigerImage = CGImageSourceCreateImageAtIndex(isrc, 0, NULL);
    
    CFRelease(isrc);
    
    size_t w = CGImageGetWidth(twoTigerImage);
    size_t h = CGImageGetHeight(twoTigerImage);
    
    CGFloat maxWidth = CGRectGetWidth(rect);
    CGFloat maxHeight = CGRectGetHeight(rect);
    
    if (w > maxWidth) {
        w = maxWidth;
    }
    
    if (h > maxHeight) {
        h = maxHeight;
    }
    
    CGRect targetRect = CGRectMake(0.5 * (maxWidth - w), 0.5 * (maxHeight - h), w, h);
    
    CGContextTranslateCTM(ctx, 0, maxHeight);
    CGContextScaleCTM(ctx, 1, -1);
    
    CGContextDrawImage(ctx, targetRect, twoTigerImage);
    
    CGImageRelease(twoTigerImage);
}
#else
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // Get the URL to the bundle resource.
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    
    CFStringRef name = CFStringCreateWithCString (NULL, "the_mask", kCFStringEncodingUTF8);
    
    CFURLRef url = CFBundleCopyResourceURL(mainBundle, name, CFSTR("gif"), NULL);
    
    CFRelease(name);
    
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL(url, NULL);
    
    CFRelease(url);
    
    CGImageRef theMask = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
    
    CFRelease(imageSource);
    
    size_t width = CGImageGetWidth(theMask);
    size_t height = CGImageGetHeight(theMask);
    
    size_t bitsPerComponent = CGImageGetBitsPerComponent(theMask);
    
    size_t bitsPerPixel = CGImageGetBitsPerPixel(theMask);
    
    size_t bytesPerRow = CGImageGetBytesPerRow(theMask);
    
    CGDataProviderRef dataProvider = CGImageGetDataProvider(theMask);
    
    CGImageRef imageMask = CGImageMaskCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, dataProvider, NULL, NO);
    
    CGFloat halfWidth = 0.5 * CGRectGetWidth(rect);
    CGRect r = CGRectMake(halfWidth, 0, halfWidth, CGRectGetHeight(rect));
    
    CGContextClipToMask(ctx, r, imageMask);
    
    CGImageRelease(imageMask);
    CGImageRelease(theMask);

    CFURLRef urlOfTwoTiger = CFBundleCopyResourceURL(mainBundle, CFSTR("two_tigers"), CFSTR("gif"), NULL);
    
    CGImageSourceRef isrc = CGImageSourceCreateWithURL(urlOfTwoTiger, NULL);
    
    CFRelease(urlOfTwoTiger);
    
    CGImageRef twoTigerImage = CGImageSourceCreateImageAtIndex(isrc, 0, NULL);
    
    CFRelease(isrc);
    
    size_t w = CGImageGetWidth(twoTigerImage);
    size_t h = CGImageGetHeight(twoTigerImage);
    
    CGFloat maxWidth = CGRectGetWidth(rect);
    CGFloat maxHeight = CGRectGetHeight(rect);
    
    if (w > maxWidth) {
        w = maxWidth;
    }
    
    if (h > maxHeight) {
        h = maxHeight;
    }
    
    CGRect targetRect = CGRectMake(0.5 * (maxWidth - w), 0.5 * (maxHeight - h), w, h);
    
    CGContextTranslateCTM(ctx, 0, maxHeight);
    CGContextScaleCTM(ctx, 1, -1);
    
    CGContextDrawImage(ctx, targetRect, twoTigerImage);
    
    CGImageRelease(twoTigerImage);
}
#endif

@end
