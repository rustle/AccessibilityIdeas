//
//  NSObject+RSTLAccessibility.h
//
//  Created by Doug Russell on 7/18/13.
//  Copyright (c) 2013 Doug Russell. All rights reserved.
//

#import <Foundation/Foundation.h>

// RSTLAccessibilityContainerIndexUnassigned is a large index
// value meant to cause any accessibilityContainerIndex that
// isn't set to sort to the middle
// To cause your elements to sort after elements not explicitly
// set, set your index to accessibilityContainerIndex + n
extern NSUInteger RSTLAccessibilityContainerIndexUnassigned;

@interface NSObject (RSTLAccessibility)

// Sort index within a container view or container element
@property (nonatomic) NSUInteger accessibilityContainerIndex;

@end
