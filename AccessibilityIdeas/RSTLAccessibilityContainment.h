//
//  RSTLAccessibilityContainment.h
//
//  Created by Doug Russell on 7/18/13.
//  Copyright (c) 2013 Doug Russell. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RSTLAccessibilityContainment <NSObject>

@property (nonatomic, readonly) NSArray *accessibilityElements;

- (void)addAccessibilityElement:(id)accessibilityElement;

// Maybe move the public aspect of this api onto the element as - (void)removeFromContainer;
- (void)removeAccessibilityElement:(id)accessibilityElement;

@end
