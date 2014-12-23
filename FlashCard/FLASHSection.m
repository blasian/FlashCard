//
//  FLASHSectionInterface.m
//  FlashCard
//
//  Created by Michael Spearman on 12/22/14.
//  Copyright (c) 2014 Michael Spearman. All rights reserved.
//

#import "FLASHSection.h"

@implementation FLASHSection

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
        self.rows = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *) getItems {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (FLASHCard *card in self.rows) {
        [items addObject:card];
    }
    return items;
}
- (void) addRow:(FLASHCard *)card
{
    [self.rows insertObject:card atIndex:0];
}
@end
