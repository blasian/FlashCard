//
//  Card.m
//  FlashCard
//
//  Created by Michael Spearman on 9/4/14.
//  Copyright (c) 2014 Michael Spearman. All rights reserved.
//

#import "FLASHCard.h"
#import "FLASHSet.h"

@implementation FLASHCard

- (instancetype)init
{
    self = [super init];
    if (self) {
        _front = @"Front";
        _back =  @"Back";
    }
    return self;
}

@end
