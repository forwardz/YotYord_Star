//
//  ViewController.m
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 17/8/2561 BE.
//  Copyright © 2561 Tutchavee Pongsapisuth. All rights reserved.
//

#import "ViewController.h"
#import "MyDocument.h"
#import "SearchTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = true;
    [FIRAnalytics setScreenName:@"Main" screenClass:@"class name"];
    // Do any additional setup after loading the view, typically from a nib.
    [HeaderPointObject createHeaderPointArray];
    [HeaderPointObject createHeaderPoint2Array];
    
    typeTable = 0;
    arrStar = [StarShowObject createStarShowObject];
    arrShowTable = [StarReportObject createStarReportArray];
}

-(void)saveiCloud:(NSData *)save_data{
    
    NSURL* ubiq = [[NSFileManager defaultManager]URLForUbiquityContainerIdentifier:nil];
    NSURL *ubiquitousPackage = [[ubiq URLByAppendingPathComponent:@"Documents"]  URLByAppendingPathComponent:@"iCloudYodYord.zip"];
    if(ubiquitousPackage){
        MyDocument *mydoc = [[MyDocument alloc] initWithFileURL:ubiquitousPackage];
        NSData *data = save_data;
        mydoc.dataContent = data;
        
        [mydoc saveToURL:[mydoc fileURL] forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success)
         {
             if (success)
             {
                 NSLog(@"Synced with icloud");
             }
             else
                 NSLog(@"Syncing FAILED with icloud");
             
         }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Can't save icloud"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:nil];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)loadAction:(id)sender{
    [self loadiCloud];
}

- (IBAction)editAction:(id)sender {
    PopupInputDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PopupInputDetailViewController"];
    vc.delegate = self;
    vc.signObject = signObject;
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)editWeightAction:(id)sender{
    [self gotoSettingPage:YES];
}
-(IBAction)deleteAction:(id)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Are you sure to delete?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              [self removeSignObject];
                                                          }];
    UIAlertAction* cancelACtion = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [alert addAction:cancelACtion];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)removeSignObject{
    [[SignObject shareSignObject] removeObject:signObject];
    signObject = nil;
    
    if([SignObject shareSignObject].count > 0){
        signObject = [[SignObject shareSignObject] lastObject];
    }
    
    [self drawUI];
}

-(IBAction)shareAction:(id)sender{
    
}

- (void)loadiCloud {
    if(isLoadiCloud) return;
    isLoadiCloud = true;
    //--------------------------Get data back from iCloud -----------------------------//
    id token = [[NSFileManager defaultManager] ubiquityIdentityToken];
    if (token == nil)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"iCloud not login"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:nil];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        NSError *error = nil;
        NSURL *ubiq = [[NSFileManager defaultManager]URLForUbiquityContainerIdentifier:nil];// in place of nil you can add your container name
        NSURL *ubiquitousPackage = [[ubiq URLByAppendingPathComponent:@"Documents"]URLByAppendingPathComponent:@"iCloudYodYord.zip"];
        BOOL isFileDounloaded = [[NSFileManager defaultManager]startDownloadingUbiquitousItemAtURL:ubiquitousPackage error:&error];
        if (isFileDounloaded) {
            NSLog(@"%d",isFileDounloaded);
            NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            //changing the file name as SampleData.zip is already present in doc directory which we have used for upload
            NSString* fileName = [NSString stringWithFormat:@"RecSampleData.zip"];
            NSString* fileAtPath = [documentsDirectory stringByAppendingPathComponent:fileName];
            NSData *dataFile = [NSData dataWithContentsOfURL:ubiquitousPackage];
            BOOL fileStatus = [dataFile writeToFile:fileAtPath atomically:NO];
            if (fileStatus) {
                NSMutableArray *array =  (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:dataFile];
                NSLog(@"%@",array);
                [[SignObject shareSignObject] removeAllObjects];
                [[SignObject shareSignObject] addObjectsFromArray:array];
                if(array.count) [self updateSignObjectFidnish:[[SignObject shareSignObject] firstObject]];
            }
        }
        else{
            NSLog(@"%d",isFileDounloaded);
        }
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setLabelDateView];
}

-(void)setLabelDateView{
    [self.dateView setHidden:!signObject];
    [self.lblName setText:signObject.name];
    [self.lblDate setText:[self getStringDateFromSigObject:signObject]];
    [self.lblLocation setText:signObject.city];
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([FIRAuth auth].currentUser) {
        // User is signed in.
        // ...
        
        FIRUser *user = [FIRAuth auth].currentUser;
        
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            NSData *imageData = [NSData dataWithContentsOfURL:user.photoURL];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.imgPhoto setImage:[UIImage imageWithData:imageData]];
                [self.lblUsername setText:user.displayName];
                [self loadiCloud];
            });
        });
        
    } else {
        [self performSelector:@selector(gotoLoginPage) withObject:nil afterDelay:0.6];
    }
}

-(void)gotoLoginPage{
    UIViewController *login_vc = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self presentViewController:login_vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapImageACtion:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Action Sheet" message:@"alert controller" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSError *signOutError;
        BOOL status = [[FIRAuth auth] signOut:&signOutError]; /// logout
        if (!status) {
            NSLog(@"Error signing out: %@", signOutError);
            return;
        }
        [FBSDKAccessToken setCurrentAccessToken:nil];
        [self gotoLoginPage];
    }]];
    actionSheet.popoverPresentationController.sourceView = self.imgPhoto;
    actionSheet.popoverPresentationController.sourceRect = [self.imgPhoto bounds];
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];    
}

-(void)addAction:(id)sender{
    /*
    PopupInputSignViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PopupInputSignViewController"];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
     */
    PopupInputDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PopupInputDetailViewController"];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)saveSignObjectFidnish:(SignObject *)so{
    [[SignObject shareSignObject] addObject:so];
    signObject = so;
    [self drawUI];
}
-(void)updateSignObjectFidnish:(SignObject *)so{
    signObject = so;
    
    [self drawUI];
}

-(void)drawUI{
    arrStar = [StarShowObject createStarShowObject];
    [self calculateWeakStar];
    arrShowTable = [StarReportObject createStarReportArray];
    [self calculateTableOne];
    [self calculateTableTwo];
    [self calculateSumPoint];
    [self calculateCircle];
    [self setLabelDateView];
    [self.mainCollectionView reloadData];
    [self.starTableView reloadData];
}

-(void)calculateTableOne{
    int j=0;
    for(HeaderPointObject *hpo in [HeaderPointObject shareHeaderPoint]){
        int i=0;
        StarReportObject *sro = [[arrShowTable objectAtIndex:0] objectAtIndex:j];
        for(NSString *predict in hpo.arrPredict){
            if(predict.length){
                NSPredicate *predicate;
                if(hpo.recipe == 0){
                    predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ && sign == %d",predict,i]];
                    if([signObject.arrStarSign filteredArrayUsingPredicate:predicate].count){
                        NSLog(@"%@,%d",hpo.name,i);
                        NSPredicate *predicated = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@",predict]];
                        [self updatePointSign:sro.arrPoint withPredicate:predicated withWeakStar:hpo.isWeakStar];
                    }
                }
                else if(hpo.recipe == 1) {
                    NSArray *items = [predict componentsSeparatedByString:@","];
                    BOOL bo = NO;
                    NSMutableArray *arr = [NSMutableArray array];
                    for(NSString *sub_predict in items){
                        predicate = [NSPredicate predicateWithFormat:sub_predict];
                        if([signObject.arrStarSign filteredArrayUsingPredicate:predicate].count){
                            bo = YES;
                            [arr addObjectsFromArray:[signObject.arrStarSign filteredArrayUsingPredicate:predicate]];
                        }else{
                            bo = NO;
                            break;
                        }
                    }
                    if(bo){
                        NSLog(@"%@,%d",hpo.name,i);
                        for(SignIndexObject *sio in arr){
                            NSPredicate *predict = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"star == %zd",sio.star]];
                            [self updatePointSign:sro.arrPoint withPredicate:predict withWeakStar:hpo.isWeakStar];
                        }
                        
                    }
                }else if(hpo.recipe == 2){
                    predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@",predict]];
                    if([signObject.arrStarSign filteredArrayUsingPredicate:predicate].count){
                        NSLog(@"%@,%d",hpo.name,i);
                        NSPredicate *predicated = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"star == %d",i]];
                        [self updatePointSign:sro.arrPoint withPredicate:predicated withWeakStar:hpo.isWeakStar];
                    }
                }
            }
            i++;
        }
        j++;
    }
}

-(void)calculateTableTwo{
    int j=0;
    for(HeaderPointObject *hpo in [HeaderPointObject shareHeaderPoint2]){
        int i=0;
        StarReportObject *sro = [[arrShowTable objectAtIndex:1] objectAtIndex:j];
        for(NSString *predict in hpo.arrPredict){
            NSMutableArray *arr = [signObject.arrStarSign2 objectAtIndex:i];
            NSPredicate *predicate;
            if(predict.length){
                if(hpo.recipe == 1){
                    predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@",predict]];
                    if([arr filteredArrayUsingPredicate:predicate].count){
                        NSLog(@"%@,%d",hpo.name,i);
                        for(NSNumber *num in arr){
                            NSPredicate *predict = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"star == %d",num.intValue]];
                            [self updatePointSign:sro.arrPoint withPredicate:predict withWeakStar:hpo.isWeakStar];
                        }
                    }
                }else if(hpo.recipe == 3){
                    NSArray *items = [predict componentsSeparatedByString:@","];
                    if(items.count > 0){
                        BOOL bo = NO;
                        NSMutableArray *array = [NSMutableArray array];
                        for(NSString *sub_predict in items){
                            predicate = [NSPredicate predicateWithFormat:sub_predict];
                            if([arr filteredArrayUsingPredicate:predicate].count){
                                bo = YES;
                                [array addObject:[arr filteredArrayUsingPredicate:predicate]];
                            }else{
                                bo = NO;
                                break;
                            }
                        }
                        if(bo){
                            NSLog(@"%@,%d",hpo.name,i);
                            for(NSArray *arr in array){
                                for(NSNumber *num in arr){
                                    NSPredicate *predict = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"star == %d",num.intValue]];
                                    [self updatePointSign:sro.arrPoint withPredicate:predict withWeakStar:hpo.isWeakStar];
                                }
                            }
                        }
                    }
                }
            }
            i++;
        }
        j++;
    }
}
-(void)calculateSumPoint{
    sumPoint = [[arrStar valueForKeyPath:@"@sum.point"] integerValue];
//    [self.lblSumpoint setText:[NSString stringWithFormat:@"%zd",sumPoint]];
    double sumTop = 0;
    double sumWeight = 0;
    for(StarShowObject *sso in arrStar){
        sumTop += (sso.percent * sso.weight);
        sumWeight += sso.weight;
    }
    [self.lblSumpoint setText:[NSString stringWithFormat:@"%.0f",(sumTop/sumWeight)]];
    
}

-(void)calculateCircle{
    NSMutableArray *arr = [NSMutableArray array];
    for(int i=0;i<12;i++){
        [arr addObject:[NSMutableArray array]];
    }
    for(SignIndexObject *sio in signObject.arrStarSign){
        NSMutableArray *arrs = [arr objectAtIndex:sio.sign];
        [arrs addObject:[NSNumber numberWithInteger:sio.star]];
    }
    NSLog(@"%@",arr);
}

-(void)calculateWeakStar{
    int i=0;
    for(StarShowObject *sso in arrStar){
        sso.weight = [[signObject.arrWeight objectAtIndex:i] integerValue];
        i++;
    }
}

-(void)updatePointSign:(NSArray *)arr withPredicate:(NSPredicate *)pre withWeakStar:(BOOL)isWeakStar{
    for(StarSubObject *sso in [arr filteredArrayUsingPredicate:pre]){
        sso.sign++;
        NSLog(@"ดาวจริง = %zd, คะแนน = %zd",sso.star,sso.sign);
        [self addPointToStar:sso.star withWeakStar:isWeakStar];
    }
}

-(void)addPointToStar:(NSInteger)star withWeakStar:(BOOL)isWeakStar{
    for(StarShowObject *sso in [arrStar filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"star == %zd",star]]]){
        sso.point++;
        if(isWeakStar){
            if(signObject.weakStar > 0){
                NSLog(@"ติดลบ");
                sso.percent = sso.percent - (50/signObject.weakStar);
                if(sso.percent < 0) sso.percent = 0;
            }
        }else{
            if(signObject.solidStar > 0){
                NSLog(@"ติดบวก");
                sso.percent = sso.percent + (50/signObject.weakStar);
                if(sso.percent > 100) sso.percent = 100;
            }
        }
    }
}

-(void)saveAction:(id)sender{
    if(signObject){
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[SignObject shareSignObject]];
        [self saveiCloud:data];
    }
}

- (void)settingAction:(id)sender{
    //Show action sheet
    UIButton *btn = (UIButton *)sender;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"Setting"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             NSLog(@"ตั้งค่าดวงดาว");
                                                             [self gotoSettingPage:NO];
                                                         }];
    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"Logout"
                                                             style:UIAlertActionStyleDestructive
                                                           handler:^(UIAlertAction *action) {
                                                               NSError *signOutError;
                                                               BOOL status = [[FIRAuth auth] signOut:&signOutError];
                                                               if (!status) {
                                                                   NSLog(@"Error signing out: %@", signOutError);
                                                                   return;
                                                               }else{
                                                                   [self gotoLoginPage];
                                                               }
                                                           }];
    [alertController addAction:settingAction];
    [alertController addAction:logoutAction];
    [alertController setModalPresentationStyle:UIModalPresentationPopover];

    UIPopoverPresentationController *popPresenter = [alertController
                                                     popoverPresentationController];
    popPresenter.sourceView = btn;
    popPresenter.sourceRect = btn.bounds;
    [self presentViewController:alertController animated:YES completion:nil];
        
}

-(void)gotoSettingPage:(BOOL)bo{
    SettingViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    vc.delegate = self;
    if(bo) vc.signObject = signObject;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)updateStarSettingDidfinish{
    [self drawUI];
}

- (IBAction)selectFilterAction:(id)sender {
    UISegmentedControl *sc = (UISegmentedControl *)sender;
    typeTable = sc.selectedSegmentIndex;
    [self.mainCollectionView reloadData];
    [self.starTableView reloadData];
}


#pragma mark - UICollecitonView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if(typeTable == 0) return arrShowTable.count;
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(typeTable == 0) return [[arrShowTable objectAtIndex:section] count];
//    else if(typeTable == 1){
        return [[arrShowTable objectAtIndex:typeTable-1] count];
//    }
//    else if(typeTable == 2){
//        return [[arrShowTable objectAtIndex:1] count];
//    }
//    else if(typeTable == 3){
//        return [[arrShowTable objectAtIndex:2] count];
//    }
    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCollectionViewCell" forIndexPath:indexPath];
//    if(typeTable == 3){
//
//    }else{
        StarReportObject *sro;
        if(typeTable == 0){
            sro = [[arrShowTable objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        }else{
            sro = [[arrShowTable objectAtIndex:typeTable - 1] objectAtIndex:indexPath.row];
        }
        [cell setDataCollectionCell:sro withSignObject:signObject withType:typeTable];
//    }
    return cell;
}

#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == self.tblSearch) return 1;
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.tblSearch) return [SignObject shareSignObject].count;
    if(section == 0) return arrStar.count-1;
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.tblSearch){
        SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTableViewCell"];
        SignObject *so = [[SignObject shareSignObject] objectAtIndex:indexPath.row];
        [cell.lblText setText:so.name];
        [cell.lblDate setText:[self getStringDateFromSigObject:so]];
        return cell;
    }
    StarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StarTableViewCell"];
    [cell setBackgroundColor:[UIColor clearColor]];
    StarShowObject *sso;
    if(indexPath.section == 0){
        sso = [arrStar objectAtIndex:indexPath.row];
    }else{
        sso = [arrStar objectAtIndex:arrStar.count-1];
    }
    [cell.lblStar setText:sso.name];
    if(sumPoint == 0){
        [cell setStarTableViewCell:0];
    }else{
//        [cell setStarTableViewCell:((sso.point*sso.weight)/sumPoint)];
        [cell setStarTableViewCell:(sso.percent/100.0f)];
    }
    [cell.lblWeight setText:[NSString stringWithFormat:@"%zd",sso.weight]];
    [cell.imgNumber setImage:[UIImage imageNamed:sso.image_name]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.tblSearch){
        SignObject *so = [[SignObject shareSignObject] objectAtIndex:indexPath.row];
        signObject = so;
        
        [self drawUI];
        [self.txtSearch resignFirstResponder];
    }
}
#pragma mark - Search
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"search begin");
    [UIView animateWithDuration:0.1f animations:^{
        [self.tblSearch setFrame:CGRectMake(self.tblSearch.frame.origin.x, self.tblSearch.frame.origin.y, self.tblSearch.frame.size.width, [self getTableSearchHeight])];
    }completion:^(BOOL finished) {
        [self.tblSearch reloadData];
    }];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"search search");
    searchBar.text = @"";
    [UIView animateWithDuration:0.1f animations:^{
        [self.tblSearch setFrame:CGRectMake(self.tblSearch.frame.origin.x, self.tblSearch.frame.origin.y, self.tblSearch.frame.size.width, 0)];
    }completion:^(BOOL finished) {
        [self.tblSearch reloadData];
    }];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%@",searchText);
}
-(NSInteger)getTableSearchHeight{
    NSInteger h = [SignObject shareSignObject].count * 40;
    return (h > 220 ? 220 : h);
}
@end
