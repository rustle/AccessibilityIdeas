//
//  RSTLAccessibilityElement.m
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

#import "RSTLAccessibilityElement.h"

@interface NSObject (RSTLAccessibilityFrame)
@property (nonatomic, readonly) CGRect frame;
@end

@interface RSTLAccessibilityElement ()
@property (nonatomic) bool hasValidFrame;
@property (weak, nonatomic) UIView *viewContainer;
@property (weak, nonatomic) RSTLAccessibilityElement *elementContainer;
@end

@implementation RSTLAccessibilityElement

- (id)initWithAccessibilityContainer:(id)container
{
	self = [super initWithAccessibilityContainer:container];
	if (self)
	{
		if ([container isKindOfClass:[UIView class]])
		{
			_viewContainer = container;
		}
		else if ([container isKindOfClass:[RSTLAccessibilityElement class]])
		{
			_elementContainer = container;
		}
		else
		{
			@throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"invalid container %@", container] userInfo:nil];
		}
	}
	return self;
}

- (void)setFrame:(CGRect)frame
{
	_frame = frame;
	self.hasValidFrame = true;
}

- (void)setAccessibilityFrame:(CGRect)accessibilityFrame
{
	[super setAccessibilityFrame:accessibilityFrame];
	_frame = CGRectZero;
	self.hasValidFrame = false;
}

- (CGRect)accessibilityFrame
{
	if (self.hasValidFrame)
	{
		CGRect frame = self.frame;
		UIView *viewContainer = self.viewContainer;
		if (!viewContainer)
		{
			RSTLAccessibilityElement *elementContainer = self.elementContainer;
			if (elementContainer)
			{
				while (elementContainer) 
				{
					if (!elementContainer.hasValidFrame)
					{
						@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"container doesn't have a valid frame" userInfo:nil];
					}
					frame.origin.x += elementContainer.frame.origin.x;
					frame.origin.y += elementContainer.frame.origin.y;
					RSTLAccessibilityElement *nextElementContainer = elementContainer.elementContainer;
					if (nextElementContainer)
					{
						elementContainer = nextElementContainer;
					}
					else
					{
						viewContainer = elementContainer.viewContainer;
						elementContainer = nil;
					}
				}
			}
		}
		if (viewContainer)
		{
			UIWindow *window = [viewContainer window];
			if (window)
			{
				frame = [viewContainer convertRect:frame toView:window];
				frame = [window convertRect:frame toWindow:nil];
				return frame;
			}
		}
	}
	return [super accessibilityFrame];
}

@end
