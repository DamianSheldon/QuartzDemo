//
//  Scene.m
//  QuartzDemo
//
//  Created by Meiliang Dong on 21/09/2017.
//  Copyright © 2017 Meiliang Dong. All rights reserved.
//

#import "Scene.h"

@interface Scene ()

@property (nonatomic) NSString *title;
@property (nonatomic) Class clz;

@end

@implementation Scene

- (instancetype)initWithTitle:(NSString *)title class:(Class)clz
{
    self = [super init];
    if (self) {
        _title = title.copy;
        _clz = clz;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithTitle:nil class:nil];
}

@end
