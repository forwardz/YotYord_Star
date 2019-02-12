//
//  SettingStarTableViewCell.m
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 2/12/19.
//  Copyright © 2019 Tutchavee Pongsapisuth. All rights reserved.
//

#import "SettingStarTableViewCell.h"

@implementation SettingStarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)sliAction:(id)sender {
    UISlider *sli = (UISlider *)sender;
    double a = sli.value * 10;
    if(a < 1) a = 1;
     [self.lblWeight setText:[NSString stringWithFormat:@"%.0f",a]];
    if([self.delegate respondsToSelector:@selector(updateWeight:withIndexPath:)]){
        [self.delegate updateWeight:a withIndexPath:self.indexPath];
    }
}
@end
