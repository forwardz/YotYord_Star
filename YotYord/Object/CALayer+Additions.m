//
//  CALayer+Additions.m
//  RetailStory
//
//  Created by Tutchavee Pongsapisuth on 2/15/2560 BE.
//  Copyright © 2560 Tutchavee Pongsapisuth. All rights reserved.
//

#import "CALayer+Additions.h"

@implementation CALayer (Additions)
- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
@end
