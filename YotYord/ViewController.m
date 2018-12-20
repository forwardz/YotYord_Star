//
//  ViewController.m
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 17/8/2561 BE.
//  Copyright © 2561 Tutchavee Pongsapisuth. All rights reserved.
//

#import "ViewController.h"
#import "MyDocument.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [FIRAnalytics setScreenName:@"Main" screenClass:@"class name"];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    arrStar = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StarShowPlist" ofType:@"plist"]];
    
    [HeaderPointObject createHeaderPointArray];
    [HeaderPointObject createHeaderPoint2Array];
    
    typeTable = 0;
    arrShowTable = [StarReportObject createStarReportArray];
//    arrShowTable = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StarReportPlist" ofType:@"plist"]];
//    arrShowTable = [HeaderPointObject shareHeaderPoint];
    /*
    progressView.progress = 0.40;
    progressView.background = [UIColor colorWithRed:219/255.0f green:219/255.0f blue:219/255.0f alpha:1.0];
    progressView.color = [UIColor colorWithRed:1/255.0f green:181/255.0f blue:254/255.0f alpha:1.0];
    progressView.type = LDProgressSolid;
    progressView.showBackgroundInnerShadow = @NO;
    progressView.flat = @YES;
    
    progressView.showStroke = @NO;
    [progressView overrideProgressTextColor:[UIColor whiteColor]];
    */
    
}

-(void)saveiCloud:(NSData *)save_data{
    
    NSURL* ubiq = [[NSFileManager defaultManager]URLForUbiquityContainerIdentifier:nil];
    NSURL *ubiquitousPackage = [[ubiq URLByAppendingPathComponent:@"Documents"]  URLByAppendingPathComponent:@"iCloudPictures.zip"];
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
-(IBAction)deleteAction:(id)sender{
    
}
-(IBAction)shareAction:(id)sender{
    
}

- (void)loadiCloud {
    
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
        NSURL *ubiquitousPackage = [[ubiq URLByAppendingPathComponent:@"Documents"]URLByAppendingPathComponent:@"iCloudPictures.zip"];
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
                SignObject *so =  (SignObject *)[NSKeyedUnarchiver unarchiveObjectWithData:dataFile];
                [self saveSignObjectFidnish:so];
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
    
    arrShowTable = [StarReportObject createStarReportArray];

    
    [self calculateTableOne];
    [self calculateTableTwo];
    [self setLabelDateView];
    [self.mainCollectionView reloadData];
    [self.starTableView reloadData];
}
-(void)updateSignObjectFidnish:(SignObject *)so{
    signObject = so;
    
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
                        for(StarSubObject *sso in [sro.arrPoint filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@",predict]]]){
                            sso.sign++;
                            NSLog(@"ดาวจริง = %zd, คะแนน = %zd",sso.star,sso.sign);
                        }
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
                        NSLog(@"%@",arr);
                        NSLog(@"%@,%d",hpo.name,i);
                        for(SignIndexObject *sio in arr){
                            NSPredicate *predict = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"star == %zd",sio.star]];
                            for(StarSubObject *sso in [sro.arrPoint filteredArrayUsingPredicate:predict]){
                                sso.sign++;
                                NSLog(@"ดาวจริง = %zd, คะแนน = %zd",sso.star,sso.sign);
                            }
                        }
                        
                    }
                }else if(hpo.recipe == 2){
                    predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@",predict]];
                    if([signObject.arrStarSign filteredArrayUsingPredicate:predicate].count){
                        NSLog(@"%@,%d",hpo.name,i);
                        for(StarSubObject *sso in [sro.arrPoint filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"star == %d",i]]]){
                            sso.sign++;
                            NSLog(@"ดาวจริง = %zd, คะแนน = %zd",sso.star,sso.sign);
                        }
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
                            for(StarSubObject *sso in [sro.arrPoint filteredArrayUsingPredicate:predict]){
                                sso.sign++;
                                NSLog(@"ดาวจริง = %zd, คะแนน = %zd",sso.star,sso.sign);
                            }
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
                                    for(StarSubObject *sso in [sro.arrPoint filteredArrayUsingPredicate:predict]){
                                        sso.sign++;
                                        NSLog(@"ดาวจริง = %zd, คะแนน = %zd",sso.star,sso.sign);
                                    }
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

-(void)saveAction:(id)sender{
    if(signObject){
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:signObject];
        [self saveiCloud:data];
    }
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
    else if(typeTable == 1){
        return [[arrShowTable objectAtIndex:0] count];
    }
    else if(typeTable == 2){
        return [[arrShowTable objectAtIndex:1] count];
    }
    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCollectionViewCell" forIndexPath:indexPath];
    StarReportObject *sro;
    if(typeTable == 0){
        sro = [[arrShowTable objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    else if(typeTable == 1){
        sro = [[arrShowTable objectAtIndex:0] objectAtIndex:indexPath.row];
    }
    else if(typeTable == 2){
        sro = [[arrShowTable objectAtIndex:1] objectAtIndex:indexPath.row];
    }
    [cell setDataCollectionCell:sro withSignObject:signObject withType:typeTable];
    return cell;
}

#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrStar.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StarTableViewCell"];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.lblStar setText:[arrStar objectAtIndex:indexPath.row]];
    [cell setStarTableViewCell:((float)arc4random() / UINT32_MAX)];
    return cell;
}
@end
