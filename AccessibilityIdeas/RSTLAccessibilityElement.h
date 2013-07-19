//
//  RSTLAccessibilityElement.h
//
//  Created by Doug Russell on 7/18/13.
//  Copyright (c) 2013 Doug Russell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+RSTLAccessibility.h"

@interface RSTLAccessibilityElement : UIAccessibilityElement

// Could be interesting to make frame a calculated property and add in 
// bounds/center/transform properties to make the element
// geometry better map to UIViews geometry

// Elements frame (in accessibilityContainer's coordinate system)
// Value of frame after directly setting accessibilityFrame is undefined
@property (nonatomic) CGRect frame;

// container must be either a view or a RSTLAccessibilityElement
//- (instancetype)initWithAccessibilityContainer:(id)container;

@end
