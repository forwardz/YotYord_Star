//
//  ShadowView.m
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 2/27/19.
//  Copyright © 2019 Tutchavee Pongsapisuth. All rights reserved.
//

#import "ShadowView.h"

@implementation ShadowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    [super awakeFromNib];
//    if (self.tag == 5) {
    self.backgroundColor = [UIColor whiteColor];
        [self.layer setCornerRadius:5.0f];
        self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5.0, 5.0)] CGPath];
//    }else {
//        [self.layer setCornerRadius:10.0f];
//        self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10.0, 10.0)] CGPath];
//    }
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.2;
    self.layer.masksToBounds = NO;
}

@end
