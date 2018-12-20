//
//  StarTableViewCell.h
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 11/9/2561 BE.
//  Copyright © 2561 Tutchavee Pongsapisuth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDProgressView.h"
@interface StarTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblStar;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

-(void)setStarTableViewCell:(double)value;
@end
