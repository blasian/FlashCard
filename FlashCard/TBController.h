//
//  TBController.h
//  FlashCard
//
//  Created by Michael Spearman on 11/11/14.
//  Copyright (c) 2014 Michael Spearman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLASHCard;
@class FLASHFrontViewController;

@interface TBController : UITabBarController

@property FLASHCard *currentCard;
@property FLASHFrontViewController *frontVC;
@property FLASHFrontViewController *backVC;

@end
