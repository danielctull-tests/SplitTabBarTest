//
//  TabBarController.m
//  SplitTabBarTest
//
//  Created by Daniel Tull on 06.02.2013.
//  Copyright (c) 2013 Daniel Tull. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController () <UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) UIViewController *currentViewController;
@end

@implementation TabBarController

- (void)setViewControllers:(NSArray *)viewControllers {

	[_viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger i, BOOL *stop) {
		[viewController willMoveToParentViewController:nil];
		[viewController removeFromParentViewController];
	}];

	_viewControllers = [viewControllers copy];

	[_viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger i, BOOL *stop) {
		[self addChildViewController:viewController];
		[viewController didMoveToParentViewController:self];
	}];

	NSLog(@"%@:%@ %@", self, NSStringFromSelector(_cmd), _viewControllers);

	self.currentViewController = (_viewControllers.count > 0) ? [_viewControllers objectAtIndex:0] : nil;

	NSLog(@"%@:%@ %@", self, NSStringFromSelector(_cmd), self.currentViewController);

	[self layout];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self layout];
}

- (void)layout {
	if (!self.isViewLoaded) return;
	if (!self.currentViewController) return;
	self.currentViewController.view.frame = self.containerView.bounds;
	[self.containerView addSubview:self.currentViewController.view];
	self.tabBar.items = [self.viewControllers valueForKey:@"tabBarItem"];
	self.tabBar.selectedItem = (self.tabBar.items.count > 0) ? [self.tabBar.items objectAtIndex:0] : nil;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {

	CGRect tabBarFrame = self.tabBar.bounds;
	CGRect frame = self.view.bounds;
	if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
		frame.size.height -= tabBarFrame.size.height;

	tabBarFrame.origin.y = frame.size.height;

	[UIView animateWithDuration:duration animations:^{
		self.containerView.frame = frame;
		self.tabBar.frame = tabBarFrame;
	}];
}

#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
	UIViewController *viewController = [self.viewControllers objectAtIndex:[self.tabBar.items indexOfObject:item]];
	viewController.view.frame = self.containerView.bounds;
	[self.containerView addSubview:viewController.view];
	[self.currentViewController.view removeFromSuperview];
	self.currentViewController = viewController;
}

@end
