//
//  MaskWithImageMaskView.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 27/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "MaskWithImageMaskOperation.h"

@import ImageIO;

@interface MaskWithImageMaskOperation ()

@property (nonatomic) UIImage *maskedImage;

@end

@implementation MaskWithImageMaskOperation

- (void)main
{
    @try {
        // Do some work on myData and report the results.
        
        // Get the URL to the bundle resource.
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        
        CFStringRef name = CFStringCreateWithCString (NULL, "two_tiger_mask", kCFStringEncodingUTF8);
        
        CFURLRef url = CFBundleCopyResourceURL(mainBundle, name, CFSTR("gif"), NULL);
        
        CFRelease(name);
        
        CGImageSourceRef imageSource = CGImageSourceCreateWithURL(url, NULL);
        
        CFRelease(url);
        
        CGImageRef twoTigerMaskImage = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
        
        CFRelease(imageSource);
        
        size_t width = CGImageGetWidth(twoTigerMaskImage);
        size_t height = CGImageGetHeight(twoTigerMaskImage);
        
        size_t bitsPerComponent = CGImageGetBitsPerComponent(twoTigerMaskImage);
        
        size_t bitsPerPixel = CGImageGetBitsPerPixel(twoTigerMaskImage);
        
        size_t bytesPerRow = CGImageGetBytesPerRow(twoTigerMaskImage);
        
        CGDataProviderRef dataProvider = CGImageGetDataProvider(twoTigerMaskImage);
        
        CGImageRef imageMask = CGImageMaskCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, dataProvider, NULL, NO);
        
        CGImageRelease(twoTigerMaskImage);
        
        CFURLRef urlOfTwoTiger = CFBundleCopyResourceURL(mainBundle, CFSTR("two_tigers"), CFSTR("gif"), NULL);
        
        CGImageSourceRef isrc = CGImageSourceCreateWithURL(urlOfTwoTiger, NULL);
        
        CFRelease(urlOfTwoTiger);
        
        CGImageRef twoTigerImage = CGImageSourceCreateImageAtIndex(isrc, 0, NULL);
        
        CFRelease(isrc);
        
        CGImageRef maskedImage = CGImageCreateWithMask(twoTigerImage, imageMask);
        
        CGImageRelease(twoTigerImage);
        CGImageRelease(imageMask);
        
        self.maskedImage = [UIImage imageWithCGImage:maskedImage];
    
        CGImageRelease(maskedImage);
    }
    @catch(NSException *exception) {
        // Do not rethrow exceptions.
    }
}

@end
