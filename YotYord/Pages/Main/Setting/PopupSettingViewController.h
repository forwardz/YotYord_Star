//
//  PopupSettingViewController.h
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 2/12/19.
//  Copyright © 2019 Tutchavee Pongsapisuth. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopupSettingViewControllerDelegate <NSObject>
-(void)logout;
-(void)selectSettingStar;
@end

@interface PopupSettingViewController : UIViewController

@property (assign, nonatomic) id<PopupSettingViewControllerDelegate> delegate;

-(IBAction)icloudAction:(id)sender;
-(IBAction)settingAction:(id)sender;
-(IBAction)logoutAction:(id)sender;
@end
