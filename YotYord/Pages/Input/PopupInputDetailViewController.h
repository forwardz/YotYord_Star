//
//  PopupInputDetailViewController.h
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 20/9/2561 BE.
//  Copyright © 2561 Tutchavee Pongsapisuth. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PopupInputDetailDelegate <NSObject>
@optional;
// Popup Search
-(void)saveSignObjectFidnish:(SignObject *)so;
-(void)updateSignObjectFidnish:(SignObject *)so;
@end

@interface PopupInputDetailViewController : UIViewController<UIWebViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    
    UIWebView *webView;
    NSMutableArray *arrNumber,*arrParam;
    NSMutableArray *arrRasi;
    NSMutableArray *arrResult;
    SignObject *so;
    BOOL isCalLuckna;
    NSString *luckana;
    
    NSString *hour,*mininute,*second;
    NSString *date,*month,*year,*zone;
    
    NSString *b_hour,*b_minute,*b_second;
}
- (IBAction)calculateAction:(id)sender;
- (IBAction)backAction:(id)sender;

@property (nonatomic, assign) id<PopupInputDetailDelegate> delegate;
@property (nonatomic, retain) SignObject *signObject;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *timePicker;

@property (nonatomic,weak) IBOutlet UITextField *txtName;
//@property (nonatomic,weak) IBOutlet UITextField *txtDate;
//@property (nonatomic,weak) IBOutlet UITextField *txtMonth;
//@property (nonatomic,weak) IBOutlet UITextField *txtYear;
//@property (nonatomic,weak) IBOutlet UITextField *txtHour;
//@property (nonatomic,weak) IBOutlet UITextField *txtMinute;
//@property (nonatomic,weak) IBOutlet UITextField *txtSecond;
@property (nonatomic,weak) IBOutlet UITextField *txtZone;
@end

NS_ASSUME_NONNULL_END
