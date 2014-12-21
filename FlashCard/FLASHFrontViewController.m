//
//  FLASHFrontViewController.m
//  FlashCard
//
//  Created by Michael Spearman on 10/6/14.
//  Copyright (c) 2014 Michael Spearman. All rights reserved.
//

#import "FLASHFrontViewController.h"
#import "FLASHCard.h"
#import "FLASHCardStore.h"

@interface FLASHFrontViewController ()

@property (weak, nonatomic) IBOutlet UITextView *cardText;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeLeft;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeRight;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@end

@implementation FLASHFrontViewController
@synthesize side;

- (void) saveData
{
    if (side == 0) {
        _card.front = self.cardText.text;
    } else {
        _card.back = self.cardText.text;
    }
}

- (void) updateData
{
    if (side == 0) {
        self.cardText.text = _card.front;
        //self.navigationController.navigationBar.topItem.title = @"Front";
    } else {
        self.cardText.text = _card.back;
        //self.navigationController.navigationBar.topItem.title = @"Back";
    }
}

- (IBAction)flip:(id)sender
{
    if (side == 0) {
        [UIView animateWithDuration:0.25
                         animations:^{
                             [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                             [self.navigationController pushViewController:_otherSide animated:NO];
                             [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
                         }];
    } else {
        [UIView animateWithDuration:0.25
                         animations:^{
                             [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                             [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
                         }];
        [self.navigationController popViewControllerAnimated:NO];
    }
}


- (IBAction)newCard:(id)sender
{
    NSArray *cards = [[FLASHCardStore sharedStore] allCards];
    [self saveData];

    if (sender == _swipeLeft) {
        if ([cards indexOfObject:_card] == ([cards count] - 1)) {
            return;
        }
        // Find next card
        _card = cards[[cards indexOfObject:_card] + 1];
    } else {
        if ([cards indexOfObject:_card] == 0) {
            return;
        }
        // Find prev card
        _card = cards[[cards indexOfObject:_card] - 1];
    }
    
    // Update views
    self.otherSide.card = _card;
    [self updateData];
}

- (IBAction)editSelected:(id)sender {
    if ([self isEditing]) {
        [self setEditing:NO animated:NO];
    } else {
        [self setEditing:YES animated:NO];
    }
}

- (IBAction)goBack:(id)sender {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (editing) {
        self.cardText.editable = YES;
        [_editButton setTitle:@"Done"];
    } else {
        [_editButton setTitle:@"Edit"];
        [self.cardText resignFirstResponder];
        self.cardText.editable = NO;
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateData];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self setEditing:NO animated:NO];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self saveData];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flip:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
}
@end
