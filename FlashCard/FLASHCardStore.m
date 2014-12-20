//
//  FLASHCardStore.m
//  FlashCard
//
//  Created by Michael Spearman on 9/4/14.
//  Copyright (c) 2014 Michael Spearman. All rights reserved.
//

#import "FLASHCardStore.h"
#import "FLASHCard.h"

@interface FLASHCardStore ()

@property (nonatomic) NSMutableArray *privateCards;

@end

@implementation FLASHCardStore

int i = 0;

+ (instancetype)sharedStore
{
    static FLASHCardStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use designated init: [FLASHCardStore sharedStore]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _privateCards = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allCards
{
    return self.privateCards;
}

- (FLASHCard *)addCard
{
    FLASHCard *card = [[FLASHCard alloc] init];
    card.front = [@(i) stringValue];
    card.back = [@(i) stringValue];
    [_privateCards addObject:card];
    i++;
    return card;
}

- (void)removeCard:(FLASHCard *)card
{
    [_privateCards removeObjectIdenticalTo:card];
}

- (void)moveCardFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    FLASHCard *card = [_privateCards objectAtIndex:fromIndex];
    [_privateCards removeObjectAtIndex:fromIndex];
    [_privateCards insertObject:card atIndex:toIndex];
}



@end
