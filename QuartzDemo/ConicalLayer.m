//
//  ConicalLayer.m
//  Radar
//
//  Created by Meiliang Dong on 19/09/2017.
//  Copyright © 2017 ABCoder. All rights reserved.
//

#import "ConicalLayer.h"

@implementation ConicalLayer

- (void)drawInContext:(CGContextRef)ctx
{
    // Draw background
    CGRect rect = CGContextGetClipBoundingBox(ctx);
    CGContextSetFillColorWithColor(ctx, self.backgroundColor);
    CGContextFillRect(ctx, rect);
    
    if (self.colors.count < 1) {
        return;
    }
    else if (self.colors.count < 2) {
        // There is only one color so directly draw with it
        CGColorRef color = (__bridge CGColorRef)(self.colors.firstObject);
        CGContextSetFillColorWithColor(ctx, color);
        CGContextFillRect(ctx, rect);
        return;
    }
    
//    CGColorRef color = (__bridge CGColorRef)(self.colors.firstObject);
    
//    CGColorSpaceRef colorSpace = CGColorGetColorSpace(color);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    size_t width = rect.size.width;
    size_t height = rect.size.height;
    
    size_t bitsPerCompoent = 8;
    size_t bytesPerRow = width * 4;
    
    size_t bitmapByteCount = bytesPerRow * height;
    
//    uint8_t *bitmapData = calloc( bitmapByteCount, sizeof(uint8_t) );
    uint32_t *bitmapData = calloc( bitmapByteCount / sizeof(uint32_t), sizeof(uint32_t) );

    // Map color to linear array each compoent occupy 1 byte
    uint8_t *colorCompoents = calloc(self.colors.count * 4, sizeof(uint8_t));
    
    for (int i = 0; i < self.colors.count; ++i) {
        CGColorRef c = (__bridge CGColorRef)(self.colors[i]);
        
        const CGFloat *compoents = CGColorGetComponents(c);
        
        uint8_t red = compoents[0] * 255;
        uint8_t green = compoents[1] * 255;
        uint8_t blue = compoents[2] * 255;
        uint8_t alpha = compoents[3] * 255;
        
        int index = i * 4;
        *(colorCompoents + index) = red;
        *(colorCompoents + index + 1) = green;
        *(colorCompoents + index + 2) = blue;
        *(colorCompoents + index + 3) = alpha;
    }
    
    // Create conical gradient bitmap data
    CGFloat centerX = width * 0.5;
    CGFloat centerY = height * 0.5;
    
    double baseAngle = 2*M_PI / (self.colors.count - 1);
        
    for (int i = 0; i < height; ++i) {
        for (int j = 0; j < width; ++j) {
            CGFloat x = j - centerX;
            CGFloat y = i - centerY;
            
            // define atan2 uniquely one uses the principal value in the range (−π, π]. That is, −π < atan2(y, x) ≤ π.
            double angle = atan2(y, x);
            
            // Convert atan2 result angle to range [0, 2π]
            if (angle < 0) {
                angle += 2 * M_PI;
            }
            
            // 0-360 map to linear gradient
            double angleRatio = angle / baseAngle;
            int colorIndex = angleRatio; // How many times of base angle?
            
            angle -= colorIndex * baseAngle;
            angleRatio = angle / baseAngle;
            
            colorIndex *= 4;
            
            uint8_t red0 = colorCompoents[colorIndex];
            uint8_t red1 = colorCompoents[colorIndex + 4];
            
            // Green index
            colorIndex += 1;
            uint8_t green0 = colorCompoents[colorIndex];
            uint8_t green1 = colorCompoents[colorIndex + 4];
            
            // Blue index
            colorIndex += 1;
            uint8_t blue0 = colorCompoents[colorIndex];
            uint8_t blue1 = colorCompoents[colorIndex + 4];
            
            // Alpha index
            colorIndex += 1;
            uint8_t alpha0 = colorCompoents[colorIndex];
            uint8_t alpha1 = colorCompoents[colorIndex + 4];
            
//            uint8_t red = red0 + angleRatio * (red1 - red0);
//            uint8_t green = green0 + angleRatio * (green1 - green0);
//            uint8_t blue = blue0 + angleRatio * (blue1 - blue0);
//            uint8_t alpha = alpha0 + angleRatio * (alpha1 - alpha0);
            
            uint8_t red = lerp(red0, red1, angleRatio);
            uint8_t green = lerp(green0, green1, angleRatio);
            uint8_t blue = lerp(blue0, blue1, angleRatio);
            uint8_t alpha = lerp(alpha0, alpha1, angleRatio);
            
            // Multiple alpha
            float a = alpha / 255.0;
            
            red *= a;
            green *= a;
            blue *= a;
            
            unsigned long index = i * width + j;
            
            *(bitmapData + index) = (red << 24) | (green << 16) | (blue << 8) | alpha;
        }
    }
    
    // Creating a Bitmap Graphics Context for conical gradient
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Little;

    CGContextRef bitmapGraphicsCtx = CGBitmapContextCreate(bitmapData, width, height, bitsPerCompoent, bytesPerRow, colorSpace, bitmapInfo);
    
    // Creating conical gradient from a Bitmap Graphics Context
    CGImageRef conicalGradientImage = CGBitmapContextCreateImage(bitmapGraphicsCtx);
    
    CGContextRelease(bitmapGraphicsCtx);
    
    free(colorCompoents);
    
    free(bitmapData);
    
    CGColorSpaceRelease(colorSpace);
    
    // Draws conical gradient image into a graphics context.
    CGContextDrawImage(ctx, rect, conicalGradientImage);
    
    CGImageRelease(conicalGradientImage);
    
    // Draws three concentric
    CGContextBeginPath(ctx);
    
    CGFloat halfWidth = 0.5 * CGRectGetWidth(rect);
    CGFloat maxRadii = 0.8 * halfWidth;
    CGFloat radii = floor(0.33 * maxRadii);
    
    for (int i = 1; i < 4; ++i) {
        CGFloat r = radii * i;
        CGFloat dx = halfWidth - r;
        CGRect ellipseRect = CGRectInset(rect, dx, dx);
        
        CGContextAddEllipseInRect(ctx, ellipseRect);
    }
    
    CGContextSetRGBStrokeColor(ctx, 41/255.0, 234/255.0, 35/255.0, 1.0);
    CGContextStrokePath(ctx);
}

// Precise method, which guarantees v = v1 when t = 1.
static inline uint8_t lerp(uint8_t v0, uint8_t v1, float t) {
    return (1 - t) * v0 + t * v1;
}

@end
