//
//  RSTLAccessibilityElement.h
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
