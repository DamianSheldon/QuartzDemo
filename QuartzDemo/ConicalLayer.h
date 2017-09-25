//
//  ConicalLayer.h
//  Radar
//
//  Created by Meiliang Dong on 19/09/2017.
//  Copyright © 2017 ABCoder. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface ConicalLayer : CALayer

/// An array of CGColorRef objects defining the color of each gradient stop. 
@property(copy) NSArray *colors;

@end
