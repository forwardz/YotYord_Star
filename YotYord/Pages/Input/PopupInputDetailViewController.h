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

@interface PopupInputDetailViewController : UIViewController<UIWebViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    
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
    
//    NSMutableArray *arrCountry,*arrState;
    NSMutableArray *arrTimezone,*arrZone;
    NSDictionary *dictCountry;
    NSString *timezone;
}
- (IBAction)calculateAction:(id)sender;
- (IBAction)backAction:(id)sender;

@property (nonatomic, assign) id<PopupInputDetailDelegate> delegate;
@property (nonatomic, retain) SignObject *signObject;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *timePicker;

@property (nonatomic,weak) IBOutlet UITextField *txtName;
@property (nonatomic,weak) IBOutlet UITextField *txtCountry;
@property (nonatomic,weak) IBOutlet UITextField *txtCity;

@property (nonatomic,weak) IBOutlet UITableView *tblCountry;
@property (nonatomic,weak) IBOutlet UITableView *tblCity;

@end

NS_ASSUME_NONNULL_END
