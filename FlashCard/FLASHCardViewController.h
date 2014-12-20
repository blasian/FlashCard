//
//  FLASHCardViewController.h
//  FlashCard
//
//  Created by Michael Spearman on 9/4/14.
//  Copyright (c) 2014 Michael Spearman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FLASHSet;
@class FLASHFrontViewController;

@interface FLASHCardViewController : UITableViewController

@property (strong, nonatomic) FLASHSet *currentSet;

@end
