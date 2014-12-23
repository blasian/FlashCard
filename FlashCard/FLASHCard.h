//
//  FLASHCard.h
//  FlashCard
//
//  Created by Michael Spearman on 9/4/14.
//  Copyright (c) 2014 Michael Spearman. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FLASHSection;

@interface FLASHCard : NSObject

@property NSString *front;
@property NSString *back;
@property (strong, nonatomic) FLASHCard *nextCard;
@property (strong, nonatomic) FLASHCard *prevCard;
// initial = 0, correct = 1, incorrect = 2
@property (nonatomic) int section;
@property (nonatomic) int status;

@end
