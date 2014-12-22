//
//  FLASHTableViewController.m
//  FlashCard
//
//  Created by Michael Spearman on 9/4/14.
//  Copyright (c) 2014 Michael Spearman. All rights reserved.
//

#import "FLASHCardViewController.h"
#import "FLASHSet.h"
#import "FLASHCardStore.h"
#import "FLASHCard.h"
#import "FLASHFrontViewController.h"
#import "TBController.h"

@implementation FLASHCardViewController

#pragma mark - Managing the detail item

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSArray* cards = [[FLASHCardStore sharedStore] allCards];
    FLASHCard *card = cards[indexPath.row];
    
    // Init. front of card
    FLASHFrontViewController *frontVC = [storyboard instantiateViewControllerWithIdentifier:@"Front"];
    frontVC.card = card;
    frontVC.side = 0;
    frontVC.title = @"Front";
    frontVC.parent = self;
    
    // Init. back of card
    FLASHFrontViewController *backVC = [storyboard instantiateViewControllerWithIdentifier:@"Front"];
    backVC.card = card;
    backVC.side = 1;
    backVC.title = @"Back";
    backVC.parent = self;
    
    // Init. TabBar for front/back
    frontVC.otherSide = backVC;
    backVC.otherSide = frontVC;
    
    [self.navigationController pushViewController:frontVC animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Delete row");
    NSArray *cards = [[FLASHCardStore sharedStore] allCards];
    FLASHCard *card = [cards objectAtIndex:indexPath.row];
    [[FLASHCardStore sharedStore] removeCard:card];
    [self.tableView reloadData];
}

- (IBAction)addNewCard:(id)sender
{
    FLASHCard *newCard = [[FLASHCardStore sharedStore] addCard];
    NSInteger lastRow = [[[FLASHCardStore sharedStore] allCards] indexOfObject:newCard];

    NSIndexPath *path = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[FLASHCardStore sharedStore] allCards] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray *items = [[FLASHCardStore sharedStore] allCards];
    FLASHCard *item = items[indexPath.row];
    cell.textLabel.text = item.front;
    return cell;
}


@end
