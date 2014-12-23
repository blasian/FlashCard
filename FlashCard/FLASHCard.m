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
@synthesize index;

- (instancetype)init:(id)sender
{
    self = [super init];
    if (self) {
        _front = @"Front";
        _back =  @"Back";
        [self setStatus:0];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    FLASHCard *card = [[[self class] allocWithZone:zone] init];
    card.front = self.front;
    card.back = self.back;
    card.index = self.index;
    card.section = self.section;
    card.status = self.status;
    return card;
}

@end
