//
//  RSTLView.m
//
//  Created by Doug Russell on 7/18/13.
//  Copyright (c) 2013 Doug Russell. All rights reserved.
//

#import "RSTLView.h"
#import "_RSTLAccessibilityContainer.h"

@interface UIView (Private)
- (void)_didRemoveSubview:(UIView *)view;
@end

@interface RSTLView ()
@property (nonatomic, readonly) _RSTLAccessibilityContainer *accessibilityInternalContainer;
@end

@implementation RSTLView
@dynamic accessibilityElements;
@synthesize accessibilityInternalContainer=_accessibilityInternalContainer;

#pragma mark - Subview Tracking

- (void)addSubview:(UIView *)view
{
	if (_accessibilityInternalContainer && view)
	{
		[self addAccessibilityElement:view];
	}
	[super addSubview:view];
}

- (void)_didRemoveSubview:(UIView *)view
{
	if (_accessibilityInternalContainer && view)
	{
		[self removeAccessibilityElement:view];
	}
	[super _didRemoveSubview:view];
}

#pragma mark - 

- (_RSTLAccessibilityContainer *)accessibilityInternalContainer
{
	if (_accessibilityInternalContainer)
	{
		return _accessibilityInternalContainer;
	}
	_accessibilityInternalContainer = [_RSTLAccessibilityContainer new];
	for (UIView *view in self.subviews)
	{
		[self addAccessibilityElement:view];
	}
	return _accessibilityInternalContainer;
}

#pragma mark - Public API

- (NSArray *)accessibilityElements
{
	return self.accessibilityInternalContainer.accessibilityElements;
}

- (void)addAccessibilityElement:(id)accessibilityElement
{
	[self.accessibilityInternalContainer addAccessibilityElement:accessibilityElement];
}

- (void)removeAccessibilityElement:(id)accessibilityElement
{
	[self.accessibilityInternalContainer removeAccessibilityElement:accessibilityElement];
}

#pragma mark - UIAccessibility

- (NSInteger)accessibilityElementCount
{
	NSInteger count = [self.accessibilityInternalContainer accessibilityElementCount];
	return count;
}

- (id)accessibilityElementAtIndex:(NSInteger)index
{
	id element = [self.accessibilityInternalContainer accessibilityElementAtIndex:index];
	return element;
}

- (NSInteger)indexOfAccessibilityElement:(id)element
{
	NSInteger index = [self.accessibilityInternalContainer indexOfAccessibilityElement:element];
	return index;
}

@end
