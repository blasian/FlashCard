//
//  FLASHSetStore.h
//  FlashCard
//
//  Created by Michael Spearman on 9/4/14.
//  Copyright (c) 2014 Michael Spearman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLASHSet;

@interface FLASHSetStore : NSObject

@property (nonatomic, readonly)NSArray *allSets;

+ (instancetype)sharedStore;
- (FLASHSet*)addSet;
- (void)removeSet:(FLASHSet *)set;
- (void)moveSetFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end
