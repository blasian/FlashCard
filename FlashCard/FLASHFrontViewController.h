//
//  FLASHFrontViewController.h
//  FlashCard
//
//  Created by Michael Spearman on 10/6/14.
//  Copyright (c) 2014 Michael Spearman. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FLASHCard;
@class FLASHCardViewController;

@interface FLASHFrontViewController : UIViewController <UITextViewDelegate, UITabBarControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic) int side;
@property (strong, nonatomic) FLASHCard *card;
@property (strong, nonatomic) FLASHFrontViewController *otherSide;
@property (strong, nonatomic) FLASHCardViewController *parent;

@end
