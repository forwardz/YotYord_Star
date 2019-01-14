//
//  ViewController.h
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 17/8/2561 BE.
//  Copyright © 2561 Tutchavee Pongsapisuth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupInputSignViewController.h"
#import "MainCollectionViewCell.h"
#import "LDProgressView.h"
#import "StarTableViewCell.h"
#import "PopupInputDetailViewController.h"

@interface ViewController : UIViewController<PopupInputSignDelegate,PopupInputDetailDelegate,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>{
    SignObject *signObject;
    NSArray *arrStar;
    NSArray *arrShowTable;
    NSInteger typeTable;
    NSInteger sumPoint;
}
// TopBar
// Profile
@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UISearchBar *txtSearch;
@property (weak, nonatomic) IBOutlet UITableView *tblSearch;

@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;

@property (weak, nonatomic) IBOutlet UILabel *lblSumpoint;

@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *starTableView;
-(IBAction)addAction:(id)sender;
- (IBAction)selectFilterAction:(id)sender;
-(IBAction)loadAction:(id)sender;

- (IBAction)editAction:(id)sender;
- (IBAction)deleteAction:(id)sender;
- (IBAction)shareAction:(id)sender;
-(IBAction)saveAction:(id)sender;

-(IBAction)settingAction:(id)sender;
@end

