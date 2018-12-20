//
//  StarTableViewCell.m
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 11/9/2561 BE.
//  Copyright © 2561 Tutchavee Pongsapisuth. All rights reserved.
//

#import "StarTableViewCell.h"

@implementation StarTableViewCell
@synthesize progressView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    progressView.background = [UIColor colorWithRed:219/255.0f green:219/255.0f blue:219/255.0f alpha:1.0];
//    progressView.color = [UIColor colorWithRed:1/255.0f green:181/255.0f blue:254/255.0f alpha:1.0];
//    progressView.type = LDProgressSolid;
//    progressView.showBackgroundInnerShadow = @NO;
//    progressView.flat = @YES;
//
//    progressView.showStroke = @NO;
    
//    progressView.textAlignment = NSTextAlignmentCenter;
//    [progressView overrideProgressTextColor:[UIColor whiteColor]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setStarTableViewCell:(double)value{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.progress = value;
//            self.progressView.animate = @YES;
        });
        
    });
}
@end
