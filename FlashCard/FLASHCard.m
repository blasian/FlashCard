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
@synthesize status;
@synthesize nextCard;
@synthesize prevCard;

- (instancetype)init:(id)sender
{
    self = [super init];
    if (self) {
        _front = @"Front";
        _back =  @"Back";
        [self setStatus:0];
        [self setPrevCard:nil];
        [self setNextCard:nil];
    }
    return self;
}

@end
