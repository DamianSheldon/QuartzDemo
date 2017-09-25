//
//  Scene.h
//  QuartzDemo
//
//  Created by Meiliang Dong on 21/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Scene : NSObject

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) Class clz;

- (instancetype)initWithTitle:(NSString *)title class:(Class)clz;

@end
