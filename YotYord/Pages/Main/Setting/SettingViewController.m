//
//  SettingViewController.m
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 1/31/19.
//  Copyright © 2019 Tutchavee Pongsapisuth. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize signObject,delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(signObject){
        [self.lblSolidStar setText:[NSString stringWithFormat:@"%d",signObject.solidStar]];
        [self.sliSolidStar setValue:(signObject.solidStar/10.0f)];
        
        [self.lblWeakStar setText:[NSString stringWithFormat:@"%d",signObject.weakStar]];
        [self.sliWeakStar setValue:(signObject.weakStar/10.0f)];
    }else{
        [self.lblSolidStar setText:@"2"];
        [self.sliSolidStar setValue:0.2];
        
        [self.lblWeakStar setText:@"2"];
        [self.sliWeakStar setValue:0.2];
    }
}

- (IBAction)sliderValueChange:(id)sender {
    double a = self.sliSolidStar.value * 10;
    if(a < 1) a = 1;
    if(sender == self.sliSolidStar){
        [self.lblSolidStar setText:[NSString stringWithFormat:@"%.0f",a]];
    }
    else if(sender == self.sliWeakStar){
        [self.lblWeakStar setText:[NSString stringWithFormat:@"%.0f",a]];
    }
}


-(void)saveAction:(id)sender{
    signObject.weakStar = [self.lblWeakStar.text intValue];
    signObject.solidStar = [self.lblWeakStar.text intValue];
    [self backAction:nil];
    if([delegate respondsToSelector:@selector(updateStarSettingDidfinish)]){
        [delegate updateStarSettingDidfinish];
    }
}

-(void)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
