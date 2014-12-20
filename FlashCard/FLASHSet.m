//
//  FLASHSet.m
//  FlashCard
//
//  Created by Michael Spearman on 9/4/14.
//  Copyright (c) 2014 Michael Spearman. All rights reserved.
//

#import "FLASHSet.h"

@implementation FLASHSet

- (instancetype)init
{
    self = [super init];
    if (self) {
        _title = nil;
        _cards = nil;
    }
    return self;
}

@end
