//
//  FLASHSetStore.m
//  FlashCard
//
//  Created by Michael Spearman on 9/4/14.
//  Copyright (c) 2014 Michael Spearman. All rights reserved.
//

#import "FLASHSetStore.h"
#import "FLASHCard.h"
#import "FLASHSet.h"

@interface FLASHSetStore ()

@property (nonatomic) NSMutableArray *privateSets;

@end

@implementation FLASHSetStore

int p = 0;

+ (instancetype)sharedStore
{
    static FLASHSetStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use designated init: [FLASHSetStore sharedStore]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _privateSets = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allSets
{
    return self.privateSets;
}

- (FLASHSet*)addSet
{
    FLASHSet *set = [[FLASHSet alloc] init];
    set.title = [@(p) stringValue];
    p++;
    [_privateSets addObject:set];
    return set;
}

- (void)removeSet:(FLASHSet *)set
{
    [_privateSets removeObjectIdenticalTo:set];
}

-(void)moveSetFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    
    FLASHSet *set = [_privateSets objectAtIndex:fromIndex];
    [_privateSets removeObjectAtIndex:fromIndex];
    [_privateSets insertObject:set atIndex:toIndex];
}


@end
