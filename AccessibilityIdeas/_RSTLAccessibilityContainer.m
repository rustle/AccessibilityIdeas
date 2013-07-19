//
//  _RSTLAccessibilityContainer.m
//
//  Created by Doug Russell on 7/18/13.
//  Copyright (c) 2013 Doug Russell. All rights reserved.
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
