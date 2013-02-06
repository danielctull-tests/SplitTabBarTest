//
//  ViewController.m
//  SplitTabBarTest
//
//  Created by Daniel Tull on 06.02.2013.
//  Copyright (c) 2013 Daniel Tull. All rights reserved.
//

#import "ViewController.h"


NSString *const ViewControllerTitles [] = {
    @"UITabBarSystemItemMore",
    @"UITabBarSystemItemFavorites",
    @"UITabBarSystemItemFeatured",
    @"UITabBarSystemItemTopRated",
    @"UITabBarSystemItemRecents",
    @"UITabBarSystemItemContacts",
    @"UITabBarSystemItemHistory",
    @"UITabBarSystemItemBookmarks",
    @"UITabBarSystemItemSearch",
    @"UITabBarSystemItemDownloads",
    @"UITabBarSystemItemMostRecent",
    @"UITabBarSystemItemMostViewed",
};

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (id)initWithTabBarSystemItem:(UITabBarSystemItem)item {
	self = [self init];
	if (!self) return nil;
	self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:item tag:0];
	self.title = ViewControllerTitles[item];
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.label.text = self.title;
}

@end
