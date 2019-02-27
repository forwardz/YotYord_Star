//
//  SettingSelectPersonViewController.m
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 2/27/19.
//  Copyright © 2019 Tutchavee Pongsapisuth. All rights reserved.
//

#import "SettingSelectPersonViewController.h"

@interface SettingSelectPersonViewController ()

@end

@implementation SettingSelectPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self checkButton];
}
- (IBAction)selectAllAction:(id)sender {
    NSArray *arr = [self getArrayFormSelected];
    if(arr.count == [SignObject shareSignObject].count){
        [[SignObject shareSignObject] setValue:@NO forKey:@"isSelected"];
    }else{
        [[SignObject shareSignObject] setValue:@YES forKey:@"isSelected"];
    }
    [_tblPerson reloadData];
    [self checkButton];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextAction:(id)sender {
    NSArray *arr = [self getArrayFormSelected];
    SettingViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    vc.delegate = self.delegate;
    if(arr.count == 1){
        vc.signObject = [arr firstObject];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)checkButton{
    NSArray *arr = [self getArrayFormSelected];
    if(arr.count > 0){
        NSString *str = [NSString stringWithFormat:@"เลือกแล้ว (%zd)",arr.count];
        [self.btnNext setTitle:str forState:UIControlStateNormal];
        [self.btnNext setHidden:NO];
    }else{
        [self.btnNext setHidden:YES];
    }
}

-(NSArray *)getArrayFormSelected{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"isSelected == 1"];
    return [[SignObject shareSignObject] filteredArrayUsingPredicate:pre];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    if(tableView == self.tblSearch) return 1;
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [SignObject shareSignObject].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTableViewCell"];
    SignObject *so = [[SignObject shareSignObject] objectAtIndex:indexPath.row];
    [cell.lblText setText:so.name];
    [cell.lblDate setText:[self getStringDateFromSigObject:so]];
    if(so.isSelected){
        cell.backgroundColor = [UIColor greenColor];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SignObject *so = [[SignObject shareSignObject] objectAtIndex:indexPath.row];
    so.isSelected = !so.isSelected;
    [self checkButton];
    [tableView reloadData];
}
-(NSString *)getStringDateFromSigObject:(SignObject *)so{
    if(so){
        //        NSString *timezone = so.zone;
        //        if(so.zone.integerValue){
        //            timezone = [NSString stringWithFormat:@"+%@",so.zone];
        //        }
        return [NSString stringWithFormat:@"%@/%@/%@ %@:%@",so.date,so.month,so.year,so.hour,so.minute];
        //        return [NSString stringWithFormat:@"%@/%@/%@ %@:%@:%@ %@",so.date,so.month,so.year,so.hour,so.minute,so.second,timezone];
    }
    return @"";
}
@end
