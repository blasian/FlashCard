//
//  FLASHCard.h
//  FlashCard
//
//  Created by Michael Spearman on 9/4/14.
//  Copyright (c) 2014 Michael Spearman. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FLASHSet;

@interface FLASHCard : NSObject

@property NSString *front;
@property NSString *back;
@property FLASHSet *container;

@end
