//
//  SettingStarTableViewCell.h
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 2/12/19.
//  Copyright © 2019 Tutchavee Pongsapisuth. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SettingStarTableViewCellDelegate <NSObject>

-(void)updateWeight:(NSInteger)weight withIndexPath:(NSIndexPath *)indexPath;

@end

@interface SettingStarTableViewCell : UITableViewCell
@property (nonatomic, assign) id<SettingStarTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imgNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblWeight;
@property (weak, nonatomic) IBOutlet UISlider *sli;
@property (retain, nonatomic) NSIndexPath *indexPath;


- (IBAction)sliAction:(id)sender;

@end
