//
//  UIScrollView+Value.m
//  ISOCameraLDE-D
//
//  Created by Xcode Developer on 10/23/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import "UIScrollView+Value.h"


@implementation UIScrollView (Value)

@dynamic minimumValue, maximumValue;

- (void)setMinimumValue:(NSNumber *)minimumValue
{
//    self.minimumValue = [NSNumber numberWithDouble:MIN(minimumValue.floatValue, self.maximumValue.floatValue)];
    return objc_setAssociatedObject(self, @selector(minimumValue), minimumValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)minimumValue
{
//    return [NSNumber numberWithDouble:MIN(self.minimumValue.floatValue, self.maximumValue.floatValue)];
    return objc_getAssociatedObject(self, @selector(minimumValue));
}

- (void)setMaximumValue:(NSNumber *)maximumValue
{
//    self.maximumValue = [NSNumber numberWithDouble:MAX(maximumValue.floatValue, self.minimumValue.floatValue)];
    return objc_setAssociatedObject(self, @selector(maximumValue), maximumValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)maximumValue
{
//    return [NSNumber numberWithDouble:MAX(self.maximumValue.floatValue, self.minimumValue.floatValue)];
    return objc_getAssociatedObject(self, @selector(maximumValue));
}

- (NSNumber *)value
{
//    double normalizedValue = (MAX(self.maximumValue.floatValue, self.minimumValue.floatValue) - MIN(self.minimumValue.floatValue, self.maximumValue.floatValue)) * (self.bounds.origin.x - (fabs(CGRectGetMidX(self.frame) - CGRectGetMinX(self.frame))) / (self.contentSize.width - (fabs(CGRectGetMidX(self.frame) - CGRectGetMinX(self.frame))) + MIN(self.minimumValue.floatValue, self.maximumValue.floatValue)));
    double normalizedValue = self.maximumValue.floatValue * ((self.bounds.origin.x + (fabs(CGRectGetMidX(self.frame) - CGRectGetMinX(self.frame)))) / self.contentSize.width);
//    normalizedValue = (normalizedValue < MIN(self.minimumValue.floatValue, self.maximumValue.floatValue)) ? MIN(self.minimumValue.floatValue, self.maximumValue.floatValue) : (normalizedValue > MAX(self.maximumValue.floatValue, self.minimumValue.floatValue)) ? MAX(self.maximumValue.floatValue, self.minimumValue.floatValue) : normalizedValue;
    normalizedValue = (normalizedValue < self.minimumValue.floatValue) ? self.minimumValue.floatValue : (normalizedValue > self.maximumValue.floatValue) ? self.maximumValue.floatValue : normalizedValue;
    
    return [NSNumber numberWithDouble:normalizedValue];
}

- (void)setValue:(NSNumber *)value
{
    [self setContentOffset:CGPointMake(value.floatValue, 0.0) animated:TRUE];
}

@end
