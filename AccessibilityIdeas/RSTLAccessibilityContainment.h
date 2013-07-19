//
//  RSTLAccessibilityContainment.h
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

#import <Foundation/Foundation.h>

@protocol RSTLAccessibilityContainment <NSObject>

@property (nonatomic, readonly) NSArray *accessibilityElements;

- (void)addAccessibilityElement:(id)accessibilityElement;

// Maybe move the public aspect of this api onto the element as - (void)removeFromContainer;
- (void)removeAccessibilityElement:(id)accessibilityElement;

@end
