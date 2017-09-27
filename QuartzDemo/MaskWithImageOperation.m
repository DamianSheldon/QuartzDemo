//
//  MaskWithImageOperation.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 27/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "MaskWithImageOperation.h"

@import ImageIO;

@interface MaskWithImageOperation ()
{
    BOOL        executing;
    BOOL        finished;
}

@property (nonatomic) UIImage *maskedImage;

- (void)completeOperation;

@end

@implementation MaskWithImageOperation

- (id)init {
    self = [super init];
    if (self) {
        executing = NO;
        finished = NO;
    }
    return self;
}

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

- (void)start {
    // Always check for cancellation before launching the task.
    if ([self isCancelled]) {
        // Must move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)main {
    @try {
        // Do the main work of the operation here.
        // Get the URL to the bundle resource.
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        
        CFStringRef name = CFStringCreateWithCString (NULL, "two_tiger_mask", kCFStringEncodingUTF8);
        
        CFURLRef url = CFBundleCopyResourceURL(mainBundle, name, CFSTR("gif"), NULL);
        
        CFRelease(name);
        
        CGImageSourceRef imageSource = CGImageSourceCreateWithURL(url, NULL);
        
        CFRelease(url);
        
        CGImageRef twoTigerMaskImage = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
        
        CFRelease(imageSource);
        
        CFURLRef urlOfTwoTiger = CFBundleCopyResourceURL(mainBundle, CFSTR("two_tigers"), CFSTR("gif"), NULL);
        
        CGImageSourceRef isrc = CGImageSourceCreateWithURL(urlOfTwoTiger, NULL);
        
        CFRelease(urlOfTwoTiger);
        
        CGImageRef twoTigerImage = CGImageSourceCreateImageAtIndex(isrc, 0, NULL);
        
        CFRelease(isrc);
        
        /* If `mask' is an image, then it must be in a monochrome color space
         (e.g. DeviceGray, GenericGray, etc...), may not have alpha, and may not
         itself be masked by an image mask or a masking color. */
        
        CGImageRef maskedImage = CGImageCreateWithMask(twoTigerImage, twoTigerMaskImage);
        
        CGImageRelease(twoTigerImage);
        CGImageRelease(twoTigerMaskImage);
        
        self.maskedImage = [UIImage imageWithCGImage:maskedImage];
        
        CGImageRelease(maskedImage);
        
        [self completeOperation];
    }
    @catch(...) {
        // Do not rethrow exceptions.
    }
}

- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    executing = NO;
    finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end
