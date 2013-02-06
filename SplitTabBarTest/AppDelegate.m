//
//  AppDelegate.m
//  SplitTabBarTest
//
//  Created by Daniel Tull on 06.02.2013.
//  Copyright (c) 2013 Daniel Tull. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TabBarController.h"
#import "TabTableViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	TabBarController *tabBarController = [TabBarController new];
	tabBarController.viewControllers = @[
		[[ViewController alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks],
		[[ViewController alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites],
		[[ViewController alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads],
		[[ViewController alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory]
	];

	TabTableViewController *master = [[TabTableViewController alloc] initWithTabBarController:tabBarController];

	UISplitViewController *splitViewController = [UISplitViewController new];
	splitViewController.viewControllers = @[master, tabBarController];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = splitViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
