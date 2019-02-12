//
//  SettingViewController.m
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 1/31/19.
//  Copyright © 2019 Tutchavee Pongsapisuth. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController (){
    NSMutableArray *arrStar;
    NSMutableArray *arrWeigth;
}

@end

@implementation SettingViewController
@synthesize signObject,delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    arrStar = [StarShowObject createStarShowObject];
    arrWeigth = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(signObject){
        [self.lblSolidStar setText:[NSString stringWithFormat:@"%d",signObject.solidStar]];
        [self.sliSolidStar setValue:(signObject.solidStar/10.0f)];
        
        [self.lblWeakStar setText:[NSString stringWithFormat:@"%d",signObject.weakStar]];
        [self.sliWeakStar setValue:(signObject.weakStar/10.0f)];
        for(NSNumber *a in signObject.arrWeight){
            [arrWeigth addObject:a];
        }
    }else{
        [self.lblSolidStar setText:@"2"];
        [self.sliSolidStar setValue:0.2];
        
        [self.lblWeakStar setText:@"2"];
        [self.sliWeakStar setValue:0.2];
        
        for(int i=0;i<11;i++){
            [arrWeigth addObject:[NSNumber numberWithInteger:10]];
        }
    }
}

- (IBAction)sliderValueChange:(id)sender {
    UISlider *sli = (UISlider *)sender;
    double a = sli.value * 10;
    if(a < 1) a = 1;
    if(sender == self.sliSolidStar){
        [self.lblSolidStar setText:[NSString stringWithFormat:@"%.0f",a]];
    }
    else if(sender == self.sliWeakStar){
        [self.lblWeakStar setText:[NSString stringWithFormat:@"%.0f",a]];
    }
}


-(void)saveAction:(id)sender{
    if(signObject){
        signObject.weakStar = [self.lblWeakStar.text intValue];
        signObject.solidStar = [self.lblWeakStar.text intValue];
        int i=0;
        for(NSNumber *a in arrWeigth){
            [signObject.arrWeight  replaceObjectAtIndex:i withObject:a];
            i++;
        }
    }
    [self backAction:nil];
    if([delegate respondsToSelector:@selector(updateStarSettingDidfinish)]){
        [delegate updateStarSettingDidfinish];
    }
}

-(void)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrStar.count-1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingStarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingStarTableViewCell"];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.delegate = self;
    StarShowObject *sso = [arrStar objectAtIndex:indexPath.row];
    NSInteger weight = [[arrWeigth objectAtIndex:indexPath.row] integerValue];
    [cell.sli setValue:(weight/10.0f)];
    [cell.lblWeight setText:[NSString stringWithFormat:@"%zd",weight]];
    [cell.lblName setText:sso.name];
    [cell.imgNumber setImage:[UIImage imageNamed:sso.image_name]];
    cell.indexPath = indexPath;
    return cell;
}
-(void)updateWeight:(NSInteger)weight withIndexPath:(NSIndexPath *)indexPath{
    [arrWeigth replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInteger:weight]];
}
@end
