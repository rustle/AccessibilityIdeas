//
//  RSTLView.m
//
//  Created by Doug Russell on 7/18/13.
//  Copyright (c) 2013 Doug Russell. All rights reserved.
//  
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//  http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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
