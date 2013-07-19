//
//  RSTLAppDelegate.m
//
//  Created by Doug Russell on 7/18/13.
//  Copyright (c) 2013 Doug Russell. All rights reserved.
//

#import "RSTLAppDelegate.h"
#import "RSTLView.h"
#import "RSTLAccessibilityElement.h"
#import "RSTLAccessibilityContainerElement.h"

@implementation RSTLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.backgroundColor = [UIColor whiteColor];
	self.window.rootViewController = [UIViewController new];
	[self.window makeKeyAndVisible];
	
	// Make a view that we'll fill with views and elements
	
	RSTLView *view = [RSTLView new];
	view.frame = self.window.rootViewController.view.bounds;
	view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	view.isAccessibilityElement = NO;
	view.shouldGroupAccessibilityChildren = YES;
	
	// Make a faux element to go in the top left corner
	// It will sort to the fourth element in the view
	
	RSTLAccessibilityElement *element = [[RSTLAccessibilityElement alloc] initWithAccessibilityContainer:view];
	element.accessibilityLabel = @"4th";
	element.accessibilityContainerIndex = 4;
	element.frame = CGRectMake(20, 20, 40, 40);
	[view addAccessibilityElement:element];
	
	// Make a container we'll put some elements in and put it in view
	// No explicit sort order so it'll sort in an undefined order after
	// everything with an explicit sort order that isn't RSTLAccessibilityContainerIndexUnassigned + n
	
	RSTLAccessibilityContainerElement *container = [[RSTLAccessibilityContainerElement alloc] initWithAccessibilityContainer:view];
	container.isAccessibilityElement = NO;
	container.frame = CGRectMake(250, 250, 60, 60);
	[view addAccessibilityElement:container];
	
	// Add an element to the container, setting a frame which is relative to the container
	// No explicit sort order
	
	element = [[RSTLAccessibilityElement alloc] initWithAccessibilityContainer:container];
	element.accessibilityLabel = @"no explicit ordering";
	element.frame = CGRectMake(10, 10, 40, 40);
	[container addAccessibilityElement:element];
	
	// Make some subviews and give them sort indexes
	
	UILabel *subview = [UILabel new];
	subview.text = @"2nd";
	subview.frame = CGRectMake(100, 100, 40, 40);
	subview.accessibilityContainerIndex = 1;
	subview.backgroundColor = [UIColor greenColor];
	subview.isAccessibilityElement = YES;
	[view addSubview:subview];
	
	subview = [UILabel new];
	subview.text = @"1st";
	subview.frame = CGRectMake(150, 150, 40, 40);
	subview.accessibilityContainerIndex = 0;
	subview.backgroundColor = [UIColor blueColor];
	subview.isAccessibilityElement = YES;
	[view addSubview:subview];
	
	subview = [UILabel new];
	subview.text = @"3rd";
	subview.frame = CGRectMake(200, 200, 40, 40);
	subview.accessibilityContainerIndex = 2;
	subview.backgroundColor = [UIColor purpleColor];
	subview.isAccessibilityElement = YES;
	[view addSubview:subview];
	
	subview = [UILabel new];
	subview.text = @"1st after elements with no explicit ordering";
	subview.frame = CGRectMake(150, 250, 40, 40);
	subview.accessibilityContainerIndex = RSTLAccessibilityContainerIndexUnassigned + 1;
	subview.backgroundColor = [UIColor purpleColor];
	subview.isAccessibilityElement = YES;
	[view addSubview:subview];
	
	subview = [UILabel new];
	subview.text = @"not accessible";
	subview.frame = CGRectMake(10, 400, 140, 40);
	subview.backgroundColor = [UIColor lightGrayColor];
	subview.isAccessibilityElement = NO;
	[view addSubview:subview];
	
	[self.window.rootViewController.view addSubview:view];
	
	return YES;
}

@end
