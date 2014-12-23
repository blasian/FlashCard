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
#import "FLASHSection.h"

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
    FLASHSection* section = [[[FLASHCardStore sharedStore] sections] objectAtIndex:indexPath.section];
    FLASHCard *card = [section.rows objectAtIndex:indexPath.row];
    
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
    [[FLASHCardStore sharedStore] removeCard:indexPath];
    [self.tableView reloadData];
}

- (IBAction)addNewCard:(id)sender
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [[FLASHCardStore sharedStore] addCard];
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sections = [[FLASHCardStore sharedStore] sections];
    FLASHSection *sect = [sections objectAtIndex:section];
    return [sect.rows count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *sections = [[FLASHCardStore sharedStore] sections];
    FLASHSection *sect = [sections objectAtIndex:section];
    if ([sect.rows count] == 0)
        return nil;
    return sect.title;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[FLASHCardStore sharedStore] sections] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    FLASHSection *section = [[[FLASHCardStore sharedStore] sections] objectAtIndex:indexPath.section];
    FLASHCard *card = [section.rows objectAtIndex:indexPath.row];
    cell.textLabel.text = card.front;
    return cell;
}


@end
