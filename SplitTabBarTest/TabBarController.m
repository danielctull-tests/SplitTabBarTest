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

	self.selectedViewController = (_viewControllers.count > 0) ? [_viewControllers objectAtIndex:0] : nil;
	[self layout];
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController {
	[_selectedViewController.view removeFromSuperview];
	_selectedViewController = selectedViewController;
	if (!_selectedViewController) return;
	_selectedViewController.view.frame = self.containerView.bounds;
	[self.containerView addSubview:_selectedViewController.view];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self layout];
}

- (void)layout {
	if (!self.isViewLoaded) return;
	if (!self.selectedViewController) return;
	self.selectedViewController.view.frame = self.containerView.bounds;
	[self.containerView addSubview:self.selectedViewController.view];
	self.tabBar.items = [self.viewControllers valueForKey:@"tabBarItem"];
	self.tabBar.selectedItem = (self.tabBar.items.count > 0) ? [self.tabBar.items objectAtIndex:0] : nil;
	[self layoutForInterfaceOrientation:self.interfaceOrientation duration:0];
}



- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
	[super willRotateToInterfaceOrientation:interfaceOrientation duration:duration];
	[self layoutForInterfaceOrientation:interfaceOrientation duration:duration];
}

- (void)layoutForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {

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
	self.selectedViewController = [self.viewControllers objectAtIndex:[self.tabBar.items indexOfObject:item]];
}

@end
