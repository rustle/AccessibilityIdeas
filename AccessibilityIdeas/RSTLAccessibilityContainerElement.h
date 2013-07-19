//
//  RSTLAccessibilityContainerElement.h
//
//  Created by Doug Russell on 7/18/13.
//  Copyright (c) 2013 Doug Russell. All rights reserved.
//

#import "RSTLAccessibilityElement.h"
#import "RSTLAccessibilityContainment.h"

@interface RSTLAccessibilityContainerElement : RSTLAccessibilityElement <RSTLAccessibilityContainment>

@property (nonatomic, readonly) NSOrderedSet *accessibilityElementsOrderedSet;

//- (instancetype)initWithAccessibilityContainer:(id)container;

//- (void)addAccessibilityElement:(id)accessibilityElement;
//- (void)removeAccessibilityElement:(id)accessibilityElement;

//- (NSInteger)accessibilityElementCount;
//- (id)accessibilityElementAtIndex:(NSInteger)index;
//- (NSInteger)indexOfAccessibilityElement:(id)element;

@end
