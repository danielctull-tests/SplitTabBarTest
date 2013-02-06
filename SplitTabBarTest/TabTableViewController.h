//
//  TabTableViewController.h
//  SplitTabBarTest
//
//  Created by Daniel Tull on 06.02.2013.
//  Copyright (c) 2013 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarController.h"

@interface TabTableViewController : UITableViewController

- (id)initWithTabBarController:(TabBarController *)tabBarController;
@property (nonatomic, readonly) TabBarController *tabBarController;

@end
