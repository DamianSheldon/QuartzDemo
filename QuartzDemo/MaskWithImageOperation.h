//
//  MaskWithImageOperation.h
//  QuartzDemo
//
//  Created by Meiliang Dong on 27/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MaskWithImageOperation : NSOperation

@property (nonatomic, readonly) UIImage *maskedImage;

@end
