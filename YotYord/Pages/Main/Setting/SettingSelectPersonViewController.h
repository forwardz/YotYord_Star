//
//  SettingSelectPersonViewController.h
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 2/27/19.
//  Copyright © 2019 Tutchavee Pongsapisuth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTableViewCell.h"
#import "SettingViewController.h"

@interface SettingSelectPersonViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UITableView *tblPerson;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectAll;

@property (weak, nonatomic) id<SettingViewDelegate> delegate;
@end
