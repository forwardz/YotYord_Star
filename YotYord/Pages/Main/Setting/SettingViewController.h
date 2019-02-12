//
//  SettingViewController.h
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 1/31/19.
//  Copyright © 2019 Tutchavee Pongsapisuth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingStarTableViewCell.h"

@protocol SettingViewDelegate <NSObject>
-(void)updateStarSettingDidfinish;
@end

@interface SettingViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,SettingStarTableViewCellDelegate>


@property (retain, nonatomic) SignObject *signObject;

@property (weak, nonatomic) id<SettingViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *lblSolidStar;
@property (weak, nonatomic) IBOutlet UISlider *sliSolidStar;

@property (weak, nonatomic) IBOutlet UILabel *lblWeakStar;
@property (weak, nonatomic) IBOutlet UISlider *sliWeakStar;

- (IBAction)sliderValueChange:(id)sender;
-(IBAction)saveAction:(id)sender;
-(IBAction)backAction:(id)sender;
@end

