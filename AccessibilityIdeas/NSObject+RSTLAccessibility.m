//
//  NSObject+RSTLAccessibility.m
//
//  Created by Doug Russell on 7/18/13.
//  Copyright (c) 2013 Doug Russell. All rights reserved.
//

#import "NSObject+RSTLAccessibility.h"
#include <objc/runtime.h>

NSUInteger RSTLAccessibilityContainerIndexUnassigned = NSNotFound;

@implementation NSObject (RSTLAccessibility)
@dynamic accessibilityContainerIndex;

static void * accessibilityContainerIndexKey = &accessibilityContainerIndexKey;

static NSNumber *getAccessibilityContainerIndex(id object)
{
	NSNumber *accessibilityContainerIndexNumber = objc_getAssociatedObject(object, accessibilityContainerIndexKey);
	if (!accessibilityContainerIndexNumber)
	{
		accessibilityContainerIndexNumber = @(RSTLAccessibilityContainerIndexUnassigned);
	}
	return accessibilityContainerIndexNumber;
}

- (NSUInteger)accessibilityContainerIndex
{
	return [getAccessibilityContainerIndex(self) unsignedIntegerValue];
}

- (void)setAccessibilityContainerIndex:(NSUInteger)accessibilityContainerIndex
{
	objc_setAssociatedObject(self, accessibilityContainerIndexKey, @(accessibilityContainerIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
