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
#import "FLASHCardViewController.h"

@interface FLASHFrontViewController ()

@property (weak, nonatomic) IBOutlet UITextView *cardText;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeLeft;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeRight;
@property (strong, nonatomic) UIBarButtonItem *editButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *correct;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *incorrect;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation FLASHFrontViewController
@synthesize side;

#pragma mark - screen display

- (void) viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flip:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateView];
    _editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editSelected:)];
    self.navigationItem.rightBarButtonItem = _editButton;
    [self setEditing:NO animated:NO];
    // Adding back button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Cards" style:UIBarButtonItemStylePlain target:self action:@selector(backPressed)];
    self.navigationItem.leftBarButtonItem = backButton;
    // Implement Toolbar
    self.navigationController.toolbarHidden = NO;
    self.correct = [[UIBarButtonItem alloc] initWithTitle:@"Correct" style:UIBarButtonItemStylePlain target:self action:@selector(setStatus:)];
    self.incorrect = [[UIBarButtonItem alloc] initWithTitle:@"Incorrect" style:UIBarButtonItemStylePlain target:self action:@selector(setStatus:)];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    NSArray *items = [NSArray arrayWithObjects:self.correct, spacer, self.incorrect, nil];
    [self setToolbarItems:items];
}

#pragma mark - button receivers

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

- (IBAction)nextCard:(id)sender
{
    [[FLASHCardStore sharedStore] reloadData];
    NSArray *cards = [[FLASHCardStore sharedStore] allCards];
    [self saveData];
    NSLog(@"INDEX/COUNT = %d/%d", _card.index, (int) [cards count]);
    if (sender == _swipeLeft) {
        // Find next card
        if ((_card.index == [cards count] - 1)) return;
        _card = [cards objectAtIndex:_card.index + 1];
    } else if (sender == _swipeRight) {
        if ((_card.index == 0)) return;
        _card = [cards objectAtIndex:_card.index - 1];
    } else {
        if ((_card.index == [cards count] - 1)) return;
        _card = [cards objectAtIndex:_card.index];
    }
    
    // Update
    self.otherSide.card = _card;
    [self updateView];
}

- (IBAction)editSelected:(id)sender {
    if ([self isEditing]) {
        [self setEditing:NO animated:NO];
    } else {
        [self setEditing:YES animated:NO];
    }
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (editing) {
        self.cardText.editable = YES;
        self.navigationItem.rightBarButtonItem.title = @"Done";
    } else {
        self.navigationItem.rightBarButtonItem.title = @"Edit";
        [self.cardText resignFirstResponder];
        self.cardText.editable = NO;
    }
}

- (IBAction)setStatus:(id)sender
{
    if (sender == self.correct) {
        [self.card setStatus:1];
    } else {
        [self.card setStatus:2];
    }
    [self nextCard:sender];
}

- (void) backPressed
{
    [self.navigationController popToViewController:_parent animated:YES];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self saveData];
    self.navigationController.toolbarHidden = YES;
}

# pragma mark - helpers

- (void) saveData
{
    if (side == 0) {
        _card.front = self.cardText.text;
    } else {
        _card.back = self.cardText.text;
    }
}

- (void) updateView
{
    if (side == 0) {
        self.cardText.text = _card.front;
    } else {
        self.cardText.text = _card.back;
    }
}
@end
