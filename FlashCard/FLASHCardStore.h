//
//  FLASHCardStore.h
//  FlashCard
//
//  Created by Michael Spearman on 9/4/14.
//  Copyright (c) 2014 Michael Spearman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLASHCard;

@interface FLASHCardStore : NSObject

@property (nonatomic, readonly) NSArray *allCards;
@property (nonatomic, readonly) NSArray *sections;

+ (instancetype)sharedStore;
- (FLASHCard *)addCard;
- (void) reloadData;
- (void)removeCard:(NSIndexPath *)index;
//- (void)moveCardFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
@end
