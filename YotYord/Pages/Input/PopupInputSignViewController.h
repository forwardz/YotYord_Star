//
//  PopupInputSignViewController.h
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 17/8/2561 BE.
//  Copyright © 2561 Tutchavee Pongsapisuth. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopupInputSignDelegate <NSObject>
@optional;
// Popup Search
-(void)saveSignObjectFidnish:(SignObject *)so;
@end

@interface PopupInputSignViewController : UIViewController
@property (nonatomic, assign) id<PopupInputSignDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtAsc;
@property (weak, nonatomic) IBOutlet UITextField *txt1;
@property (weak, nonatomic) IBOutlet UITextField *txt2;
@property (weak, nonatomic) IBOutlet UITextField *txt3;
@property (weak, nonatomic) IBOutlet UITextField *txt4;
@property (weak, nonatomic) IBOutlet UITextField *txt5;
@property (weak, nonatomic) IBOutlet UITextField *txt6;
@property (weak, nonatomic) IBOutlet UITextField *txt7;
@property (weak, nonatomic) IBOutlet UITextField *txt8;
@property (weak, nonatomic) IBOutlet UITextField *txt9;
@property (weak, nonatomic) IBOutlet UITextField *txt0;

-(IBAction)saveAction:(id)sender;
@end
