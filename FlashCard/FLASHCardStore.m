//
//  FLASHCardStore.m
//  FlashCard
//
//  Created by Michael Spearman on 9/4/14.
//  Copyright (c) 2014 Michael Spearman. All rights reserved.
//

#import "FLASHCardStore.h"
#import "FLASHCard.h"
#import "FLASHSection.h"

@interface FLASHCardStore ()

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
        FLASHSection *unused = [[FLASHSection alloc] initWithTitle:@"Unused"];
        FLASHSection *correct = [[FLASHSection alloc] initWithTitle:@"Correct"];
        FLASHSection *incorrect = [[FLASHSection alloc] initWithTitle:@"Incorrect"];
        _sections = [[NSMutableArray alloc] initWithObjects: unused, correct, incorrect, nil];
    }
    return self;
}

- (NSArray *)allCards
{
    NSMutableArray *all = [[NSMutableArray alloc] init];
    for (FLASHSection *section in self.sections) {
        NSArray *rows = [section getItems];
        for (FLASHCard *card in rows) {
            [all addObject:card];
        }
    }
    return all;
}

- (void)reloadData
{
    for (FLASHCard *card in [self allCards]) {
        NSArray *cards = [[FLASHCardStore sharedStore] allCards];
        // Remember prev and next cards before reshuffling
        NSLog(@"indexOfObject:self = %d", (int) [cards indexOfObject:card]);
        if ([cards indexOfObject:card] != 0) {
            FLASHCard *prev = [cards objectAtIndex:[cards indexOfObject:card] - 1];
            [card setPrevCard:prev];
        }
        if ([cards indexOfObject:card] != [cards count] - 1) {
            FLASHCard *next = [cards objectAtIndex:[cards indexOfObject:card] + 1];
            [card setNextCard:next];
        }
        // Section card SHOULD be in but may not be
        if (card.status != card.section) {
            // Move card to correct section
            FLASHSection *current = [self.sections objectAtIndex:card.section];
            [current.rows removeObject:card];
            FLASHSection *future = [self.sections objectAtIndex:card.status];
            [future.rows addObject:card];
            card.section = card.status;
        }
    }
}

- (FLASHCard *)addCard
{
    FLASHCard *card = [[FLASHCard alloc] init];
    card.front = [@(i) stringValue];
    card.back = [@(i) stringValue];
    FLASHSection *section = [self.sections objectAtIndex:0];
    [section addRow:card];
    i++;
    return card;
}

- (void)removeCard:(NSIndexPath *)index
{
    FLASHSection *section = [self.sections objectAtIndex:index.section];
    [section.rows removeObjectAtIndex:index.row];
}

//- (void)moveCardFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
//{
//    FLASHCard *card = [_privateCards objectAtIndex:fromIndex];
//    [_privateCards removeObjectAtIndex:fromIndex];
//    [_privateCards insertObject:card atIndex:toIndex];
//}



@end
