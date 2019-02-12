//
//  PopupSettingViewController.m
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 2/12/19.
//  Copyright © 2019 Tutchavee Pongsapisuth. All rights reserved.
//

#import "PopupSettingViewController.h"

@interface PopupSettingViewController ()

@end

@implementation PopupSettingViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)settingAction:(id)sender{
    [self dismissViewControllerAnimated:NO completion:^{
        if([delegate respondsToSelector:@selector(selectSettingStar)]){
            [delegate selectSettingStar];
        }
    }];
}

-(IBAction)logoutAction:(id)sender{
    [self dismissViewControllerAnimated:NO completion:^{
        if([delegate respondsToSelector:@selector(logout)]){
            [delegate logout];
        }
    }];
}

@end
