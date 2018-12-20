//
//  MainCollectionViewCell.h
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 23/8/2561 BE.
//  Copyright © 2561 Tutchavee Pongsapisuth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableViewCell.h"

@interface MainCollectionViewCell : UICollectionViewCell<UITableViewDataSource,UITableViewDelegate>{
    HeaderPointObject *headerPointObject;
    StarReportObject *starReportObject;
    
    SignObject *signObject;
    NSInteger typeTable;
}

-(void)setDataCollectionCell:(StarReportObject *)hpo withSignObject:(SignObject *)so withType:(NSInteger)type;
@property (weak, nonatomic) IBOutlet UITableView *tbl;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *lblHeader;
@property (weak, nonatomic) IBOutlet UITableView *tblData;
@end
