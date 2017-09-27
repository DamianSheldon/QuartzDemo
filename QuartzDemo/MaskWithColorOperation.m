//
//  MaskWithColorOperation.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 27/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "MaskWithColorOperation.h"

@import ImageIO;

@interface MaskWithColorOperation ()

@property (nonatomic) UIImage *maskedImage;

@end

@implementation MaskWithColorOperation

- (void)main
{
    @try {
        // Do some work on myData and report the results.
        
        // Get the URL to the bundle resource.
        CFBundleRef mainBundle = CFBundleGetMainBundle();

        CFURLRef url = CFBundleCopyResourceURL(mainBundle, CFSTR("chroma_key"), CFSTR("gif"), NULL);
        
        CGImageSourceRef isrc = CGImageSourceCreateWithURL(url, NULL);
        
        CFRelease(url);
        
        CGImageRef originImage = CGImageSourceCreateImageAtIndex(isrc, 0, NULL);
        
        CFRelease(isrc);
        
        const CGFloat maskingColors[6] = {44, 118, 165, 199, 214, 230};
                
        CGImageRef maskedImage = CGImageCreateWithMaskingColors(originImage, maskingColors);
        
        CGImageRelease(originImage);
        
        self.maskedImage = [UIImage imageWithCGImage:maskedImage];
        
        CGImageRelease(maskedImage);
    }
    @catch(NSException *exception) {
        // Do not rethrow exceptions.
    }
}

@end
