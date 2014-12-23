//
//  FLASHSectionInterface.h
//  FlashCard
//
//  Created by Michael Spearman on 12/22/14.
//  Copyright (c) 2014 Michael Spearman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLASHCard.h"

@interface FLASHSection : NSObject
- (instancetype) initWithTitle:(NSString *)title;
- (NSArray *) getItems;
- (void) addRow:(FLASHCard *)card;
@property (nonatomic, weak) NSString *title;
@property (nonatomic, strong) NSMutableArray *rows;
@property (nonatomic, weak) NSArray *items;
@end