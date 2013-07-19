//
//  _RSTLAccessibilityContainer.m
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

#import "_RSTLAccessibilityContainer.h"
#import "NSObject+RSTLAccessibility.h"

@interface NSMutableOrderedSet (Private)
#warning USES PRIVATE API
- (void)sortUsingDescriptors:(NSArray *)sortDescriptors;
@end

@interface _RSTLAccessibilityContainer ()
@property (nonatomic) bool accessibilitySortOrderDirty;
// Using an ordered set to make membership testing cheap
// Might be confusing if someone wants to add an element twice
// but I'm not currently aware of a case where you'd actually want to do that
@property (nonatomic) NSMutableOrderedSet *accessibilityElementsOrderedSet;
@end

@implementation _RSTLAccessibilityContainer
@dynamic accessibilityElements;

#pragma mark - Setup/Cleanup

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		_accessibilitySortOrderDirty = true;
		_accessibilityElementsOrderedSet = [NSMutableOrderedSet new];
	}
	return self;
}

- (void)dealloc
{
	for (id accessibilityElement in _accessibilityElementsOrderedSet)
	{
		[accessibilityElement removeObserver:self forKeyPath:RSTLAccessibilityContainerIndexKeyPath context:RSTLAccessibilityContainerIndexObserverContext];
	}
}

#pragma mark - Public API

static void * RSTLAccessibilityContainerIndexObserverContext = @"RSTLAccessibilityContainerIndexObserverContext";
static NSString *const RSTLAccessibilityContainerIndexKeyPath = @"accessibilityContainerIndex";

- (void)addAccessibilityElement:(id)accessibilityElement
{
	NSParameterAssert([NSThread isMainThread]);
	if (!accessibilityElement)
	{
		@throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"BOOM!" userInfo:nil];
	}
	[accessibilityElement addObserver:self forKeyPath:RSTLAccessibilityContainerIndexKeyPath options:NSKeyValueObservingOptionNew context:RSTLAccessibilityContainerIndexObserverContext];
	[self.accessibilityElementsOrderedSet addObject:accessibilityElement];
	self.accessibilitySortOrderDirty = true;
}

- (void)removeAccessibilityElement:(id)accessibilityElement
{
	NSParameterAssert([NSThread isMainThread]);
	if (!accessibilityElement)
	{
		@throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"BOOM!" userInfo:nil];
	}
	if (![self.accessibilityElementsOrderedSet containsObject:accessibilityElement])
	{
		// We don't want to remove observers for something that was never added or has already been removed
		return;
	}
	[accessibilityElement removeObserver:self forKeyPath:RSTLAccessibilityContainerIndexKeyPath context:RSTLAccessibilityContainerIndexObserverContext];
	[self.accessibilityElementsOrderedSet removeObject:accessibilityElement];
}

- (NSArray *)accessibilityElements
{
	NSParameterAssert([NSThread isMainThread]);
	return [self.accessibilityElementsOrderedSet array];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (context == RSTLAccessibilityContainerIndexObserverContext)
	{
		dispatch_async(dispatch_get_main_queue(), ^(void) {
			self.accessibilitySortOrderDirty = true;
		});
	}
	else
	{
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

#pragma mark - Sorting

- (void)accessibilityElementsOrderedSetSortIfNeeded
{
	if (!self.accessibilitySortOrderDirty)
	{
		return;
	}
	[self.accessibilityElementsOrderedSet sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:RSTLAccessibilityContainerIndexKeyPath ascending:YES]]];
#if DEBUG && 0
	NSMutableString *description = [@"Sorted (\n" mutableCopy];
	for (id element in self.accessibilityElementsOrderedSet)
	{
		[description appendFormat:@"<%p> %lu\n", element, (unsigned long)[element accessibilityContainerIndex]];
	}
	[description appendString:@")"];
	NSLog(@"%@", description);
#endif
	self.accessibilitySortOrderDirty = false;
}

#pragma mark - UIAccessibility

- (NSInteger)accessibilityElementCount
{
	[self accessibilityElementsOrderedSetSortIfNeeded];
	NSInteger count = [self.accessibilityElementsOrderedSet count];
	return count;
}

- (id)accessibilityElementAtIndex:(NSInteger)index
{
	[self accessibilityElementsOrderedSetSortIfNeeded];
	id element = self.accessibilityElementsOrderedSet[index];
	return element;
}

- (NSInteger)indexOfAccessibilityElement:(id)element
{
	[self accessibilityElementsOrderedSetSortIfNeeded];
	NSInteger index = [self.accessibilityElementsOrderedSet indexOfObject:element];
	return index;
}

@end
