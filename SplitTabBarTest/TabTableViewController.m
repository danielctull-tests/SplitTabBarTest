//
//  TabTableViewController.m
//  SplitTabBarTest
//
//  Created by Daniel Tull on 06.02.2013.
//  Copyright (c) 2013 Daniel Tull. All rights reserved.
//

#import "TabTableViewController.h"

@interface TabTableViewController ()
@end

@implementation TabTableViewController

- (id)initWithTabBarController:(TabBarController *)tabBarController {
	self = [self initWithStyle:UITableViewStyleGrouped];
	if (!self) return nil;
	_tabBarController = tabBarController;
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.tabBarController.viewControllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UIViewController *viewController = [self.tabBarController.viewControllers objectAtIndex:indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	cell.textLabel.text = viewController.title;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:indexPath.row];
}

@end
