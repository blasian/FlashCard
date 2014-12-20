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

@property (nonatomic, readonly)NSArray *allCards;

+ (instancetype)sharedStore;
- (FLASHCard *)addCard;
- (void)removeCard:(FLASHCard *)card;
- (void)moveCardFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
@end
