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

@interface _RSTLAccessibilityContainer ()
@property (nonatomic) bool accessibilitySortOrderDirty;
@property (nonatomic) NSMutableArray *accessibilityElements;
@end

@implementation _RSTLAccessibilityContainer

#pragma mark - Setup/Cleanup

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		_accessibilitySortOrderDirty = true;
		_accessibilityElements = [NSMutableArray new];
	}
	return self;
}

#pragma mark - Public API

- (void)addAccessibilityElement:(id)accessibilityElement
{
	if (!accessibilityElement)
	{
		@throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"BOOM!" userInfo:nil];
	}
	[(NSMutableArray *)self.accessibilityElements addObject:accessibilityElement];
	self.accessibilitySortOrderDirty = true;
}

- (void)removeAccessibilityElement:(id)accessibilityElement
{
	if (!accessibilityElement)
	{
		@throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"BOOM!" userInfo:nil];
	}
	[(NSMutableArray *)self.accessibilityElements removeObject:accessibilityElement];
}

#pragma mark - Sorting

- (void)accessibilityElementsOrderedSetSortIfNeeded
{
	if (!self.accessibilitySortOrderDirty)
	{
		return;
	}
	[(NSMutableArray *)self.accessibilityElements sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"accessibilityContainerIndex" ascending:YES]]];
#if DEBUG && 0
	NSMutableString *description = [@"Sorted (\n" mutableCopy];
	for (id element in self.accessibilityElements)
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
	NSInteger count = [self.accessibilityElements count];
	return count;
}

- (id)accessibilityElementAtIndex:(NSInteger)index
{
	[self accessibilityElementsOrderedSetSortIfNeeded];
	id element = self.accessibilityElements[index];
	return element;
}

- (NSInteger)indexOfAccessibilityElement:(id)element
{
	[self accessibilityElementsOrderedSetSortIfNeeded];
	NSInteger index = [self.accessibilityElements indexOfObject:element];
	return index;
}

@end
