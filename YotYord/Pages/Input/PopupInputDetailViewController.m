//
//  PopupInputDetailViewController.m
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 20/9/2561 BE.
//  Copyright © 2561 Tutchavee Pongsapisuth. All rights reserved.
//
#define HEIGHT_TABLE_VIEW     200
#define SOLID_STAR_DEFAULT      4
#define WEAK_STAR_DEFAULT       4

#import "PopupInputDetailViewController.h"
#import "SearchTableViewCell.h"
#import "RasiObject.h"
@interface PopupInputDetailViewController (){
    NSString *JDN;
}

@end

@implementation PopupInputDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    hour = @"00";
    mininute = @"00";
    second = @"00";
    [self.datePicker setMaximumDate:[NSDate date]];
  
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierBuddhist]];
    [self.datePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"th"]];
    
    arrTimezone = [NSMutableArray arrayWithArray:[self JSONFromFile]];
    arrZone = [NSMutableArray array];

    [self loadMyWebView];
}

- (NSArray *)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"timezones" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.signObject){
        [self.txtName setText:self.signObject.name];
        [self.datePicker setDate:self.signObject.pure_date];
        [self.txtCity setText:self.signObject.city];
        [self.txtCountry setText:self.signObject.country];
        timezone = self.signObject.zone;
        
        hour = self.signObject.hour;
        mininute = self.signObject.minute;
        second = self.signObject.second;
        
        [self.timePicker selectRow:[self.signObject.hour integerValue] inComponent:0 animated:NO];
        [self.timePicker selectRow:[self.signObject.minute integerValue] inComponent:1 animated:NO];
        [self.timePicker selectRow:[self.signObject.second integerValue] inComponent:2 animated:NO];
        
        
    }else{
        [self.txtName setText:@""];
        [self.datePicker setDate:[NSDate date]];
        [self.txtCountry setText:@"(UTC+07:00) Bangkok, Hanoi, Jakarta"];
        [self.txtCity setText:@"Asia/Bangkok"];
        timezone = @"7";
    }
}

-(void)getCurrentTimeZoneMins
{
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    float timeZoneOffset = [destinationTimeZone secondsFromGMTForDate:[NSDate date]] / 60;;
    NSLog(@"%f mins",timeZoneOffset);
}

-(void)printTimeZone
{
    NSDateFormatter *localTimeZoneFormatter = [NSDateFormatter new];
    localTimeZoneFormatter.timeZone = [NSTimeZone localTimeZone];
    localTimeZoneFormatter.dateFormat = @"Z";
    NSString *localTimeZoneOffset = [localTimeZoneFormatter stringFromDate:[NSDate date]];
    NSLog(@"%@",localTimeZoneOffset);
}
-(void)calculate{
    hour = b_hour;
    mininute = b_minute;
    second = b_second;
    [webView reload];
}

-(void)loadMyWebView {
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    NSString *path;
    NSBundle *thisBundle = [NSBundle mainBundle];
    path = [thisBundle pathForResource:@"calculate_pra" ofType:@"html"];
    NSURL *instructionsURL = [NSURL fileURLWithPath:path];
    
    NSString* htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    webView.delegate = self;
    
    [webView loadHTMLString:htmlString baseURL:instructionsURL];
    [self.view addSubview:webView]; // (if you want to access the javascript function and don't want to add webview, you can skip that also.)
    
}

-(void)calculateLuckana{
    isCalLuckna = YES;
    zone = timezone;
    b_hour = hour;
    b_minute = mininute;
    b_second = second;
    
    hour = @"00";
    mininute = @"00";
    second = @"00";
    
    [webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView*)theWebView {
    if(date.length == 0) return;
    NSString *str = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@",date,month,year,hour,mininute,second,zone];
    arrRasi = [NSMutableArray array];
    arrNumber = [NSMutableArray array];
    JDN = [theWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"myFunction('%@')",str]];
    if(JDN){
        NSLog(@"JDN = %@ ",JDN);
        
        NSString* pra1 = [theWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"Pra1('%@')",JDN]];
        if(pra1){
            NSLog(@"pra 1 = %@",pra1);
            [arrNumber addObject:pra1];
        }
        NSString* pra2 = [theWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"Pra2('%@')",JDN]];
        if(pra2){
            NSLog(@"pra 2 = %@",pra2);
            [arrNumber addObject:pra2];
        }
        
        NSString* pra3 = [theWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"Pra3('%@')",JDN]];
        if(pra3){
            NSLog(@"pra 3 = %@",pra3);
            [arrNumber addObject:pra3];
        }
        
        NSString* pra4 = [theWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"Pra4('%@')",JDN]];
        if(pra4){
            NSLog(@"pra 4 = %@",pra4);
            [arrNumber addObject:pra4];
        }
        
        NSString* pra5 = [theWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"Pra5('%@')",JDN]];
        if(pra5){
            NSLog(@"pra 5 = %@",pra5);
            [arrNumber addObject:pra5];
        }
        
        NSString* pra6 = [theWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"Pra6('%@')",JDN]];
        if(pra6){
            NSLog(@"pra 6 = %@",pra6);
            [arrNumber addObject:pra6];
        }
        
        
        NSString* pra7 = [theWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"Pra7('%@')",JDN]];
        if(pra7){
            NSLog(@"pra 7 = %@",pra7);
            [arrNumber addObject:pra7];
        }
        
        NSString* pra8 = [theWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"Pra8('%@')",JDN]];
        if(pra8){
            NSLog(@"pra 8 = %@",pra8);
            [arrNumber addObject:pra8];
        }
        
        NSString* pra9 = [theWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"Pra9('%@')",JDN]];
        if(pra9){
            NSLog(@"pra 9 = %@",pra9);
            [arrNumber addObject:pra9];
        }
        
        NSString* pra0 = [theWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"Pra0('%@')",JDN]];
        if(pra0){
            NSLog(@"pra 0 = %@",pra0);
            [arrNumber addObject:pra0];
        }
        
    }
    
    int i=0;
    for(NSString *sputa in arrNumber){
        NSString*rasi = [theWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"rasi('%@')",sputa]];
        
        NSString*ongsa = [theWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"ongsa('%@')",sputa]];
        
        NSString*lipda = [theWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"lipda('%@')",sputa]];
        
        [arrRasi addObject:[RasiObject createRasiObject:rasi withOngsa:ongsa withLipda:lipda withName:[self fineNameStarFromIndex:i]]];
        i++;
    }
    
    NSLog(@"%@",arrRasi);
    
    if(isCalLuckna){
        isCalLuckna = NO;
        // คำนวณลักคนา
        luckana = @"0"; // จำลอง ลัคขนา
        RasiObject *rasiObj = [arrRasi firstObject];
        NSLog(@"result ===== %@,%@,%@",rasiObj.rasi,rasiObj.ongsa,rasiObj.lipda);
        int degree = rasiObj.rasi.doubleValue * 30;
        degree += rasiObj.ongsa.doubleValue;
        NSLog(@"%d",degree);
        luckana = [self findDegree:degree]; // ลัคนาของเที่ยงคืน
        
//        luckana = [self findDegree:0];
        
//        int degree_date = (hour.intValue * 30);
//        degree_date += mininute.intValue;
//        NSLog(@"%d",degree_date);
//
//        double sum = degree + degree_date;
//        CGFloat moduloResult = (float)((int)sum % 360);
//        NSLog(@"%f",moduloResult);
//        luckana = [NSString stringWithFormat:@"%d",(int)(moduloResult/12.0)];
        
        [self calculate];
    }else{
        if(self.signObject){
            self.signObject.s_id = [self getUniqueCode];
            self.signObject.name = self.txtName.text;
            self.signObject.pure_date = self.datePicker.date;
            self.signObject.date = date;
            self.signObject.month = month;
            self.signObject.year = year;
            self.signObject.hour = hour;
            self.signObject.minute = mininute;
            self.signObject.second = second;
            self.signObject.zone = zone;
            self.signObject.city = self.txtCity.text;
            self.signObject.country = self.txtCountry.text;
            self.signObject.arrStarSign = [NSMutableArray array];
//            self.signObject.solidStar = 2;
//            self.signObject.weakStar = 2;
//            self.signObject.arrWeight = [NSMutableArray array];
//            for(int i=0;i<9;i++){
//                [self.signObject.arrWeight addObject:[NSString stringWithFormat:@"%d",10]];
//            }
            
            SignIndexObject *sio = [self createSignIndexObject:-1 withSign:luckana];
            [self.signObject.arrStarSign addObject:sio];
            self.signObject.luckana = sio.sign;
            
            i = 1;
            for(RasiObject *rasi in arrRasi){
                if(i == 1)  NSLog(@"result ===== %@,%@,%@",rasi.rasi,rasi.ongsa,rasi.lipda);
                [self.signObject.arrStarSign addObject:[self createSignIndexObject:i withSign:rasi.rasi]];
                i++;
            }
            
            
            [self calculateNewSign:self.signObject];
            [self dismissViewControllerAnimated:YES completion:^{
                // update
                if([self.delegate respondsToSelector:@selector(updateSignObjectFidnish:)]){
                    [self.delegate updateSignObjectFidnish:self.signObject];
                }
            }];
            
        }else{
            SignObject *so = [[SignObject alloc] init];
            so.s_id = [self getUniqueCode];
            so.name = self.txtName.text;
            so.pure_date = self.datePicker.date;
            so.date = date;
            so.month = month;
            so.year = year;
            so.hour = hour;
            so.minute = mininute;
            so.second = second;
            so.zone = zone;
            so.city = self.txtCity.text;
            so.country = self.txtCountry.text;
            so.arrStarSign = [NSMutableArray array];
            so.solidStar = SOLID_STAR_DEFAULT;
            so.weakStar = WEAK_STAR_DEFAULT;
            so.arrWeight = [NSMutableArray array];
            for(int i=0;i<10;i++){
                [so.arrWeight addObject:[NSString stringWithFormat:@"%d",10]];
            }
            
            SignIndexObject *sio = [self createSignIndexObject:-1 withSign:luckana];
            [so.arrStarSign addObject:sio];
            so.luckana = sio.sign;
            
            i = 1;
            for(RasiObject *rasi in arrRasi){
                if(i == 1)  NSLog(@"result ===== %@,%@,%@",rasi.rasi,rasi.ongsa,rasi.lipda);
                [so.arrStarSign addObject:[self createSignIndexObject:i withSign:rasi.rasi]];
                i++;
            }
            
            
            [self calculateNewSign:so];
            [self dismissViewControllerAnimated:YES completion:^{
                // new
                if([self.delegate respondsToSelector:@selector(saveSignObjectFidnish:)]){
                    [self.delegate saveSignObjectFidnish:so];
                }
            }];
            
        }
        
//        NSPredicate *pre = [NSPredicate predicateWithFormat:@"s_id LIKE %@",so.s_id];
//        if([[SignObject shareSignObject] filteredArrayUsingPredicate:pre].count){
//            // update
//            if([self.delegate respondsToSelector:@selector(saveSignObjectFidnish:)]){
//                [self.delegate updateSignObjectFidnish:so];
//            }
//        }else{
//
//        }
        
        
        
    }
    
    
    /*
    ResultObject *reo = [[ResultObject alloc]init];
    reo.arrRasi = [[NSMutableArray alloc]initWithArray:arrRasi];
    reo.dateRasiObject = [arrParam objectAtIndex:index];
    [arrResult addObject:reo];
    
    
    [self.myTableView reloadData];
    
    
    for(id layer in arrSubLayer){
        [layer removeFromSuperlayer];
    }
    for(id lbl in arrLabel){
        [lbl removeFromSuperview];
    }
    [arrSubLayer removeAllObjects];
    [arrLabel removeAllObjects];
    [arrDuplicate removeAllObjects];
    
    int j=0;
    for(RasiObject *rso in arrRasi){
        double degree = rso.rasi.doubleValue*30;
        degree += rso.ongsa.doubleValue;
        [self drawLine:(degree-15) withText:[self getTextFormInt:j]];
        j++;
    }
    
    index++;
     */
    //    [self testCSV];
}
-(SignIndexObject *)createSignIndexObject:(NSInteger)star withSign:(NSString *)sign{
    SignIndexObject *sio = [[SignIndexObject alloc]init];
    sio.star = star;
    sio.sign = [sign integerValue];
    return sio;
}
-(void)calculateNewSign:(SignObject *)so{
    // luckana = 3
    // แสดงว่าช่องที่ 3 ต้องนับเป็น 1
    so.arrStarSign2 = [NSMutableArray array];
    for(int i=0;i<12;i++){
        NSInteger j = so.luckana + i;
        if(j > 11){
            j -= 12;
        }
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"sign == %d",j];
        NSMutableArray *arr = [NSMutableArray array];
        for(SignIndexObject *sio in [so.arrStarSign filteredArrayUsingPredicate:pre]){
            if(sio.star == -1){
                [arr addObject:[NSNumber numberWithInteger:-1]];
            }else{
                [arr addObject:[NSNumber numberWithInteger:sio.star]];
            }
        }
        [so.arrStarSign2 addObject:arr];
    }
}

-(void)backAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)calculateAction:(id)sender {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"dd MM YYYY"];
    [df setLocalizedDateFormatFromTemplate:@"yyyy-MM-dd"];
    [df setLocale:[NSLocale localeWithLocaleIdentifier:@"th"]];
    
//    let dateFormatter = NSDateFormatter()
//    dateFormatter.dateFormat = "MMM dd, YYYY"
    NSString *date_string = [df stringFromDate:self.datePicker.date];
//    NSLog(@"%@",date_string);
    NSArray *arr = [date_string componentsSeparatedByString:@"/"];
    NSLog(@"%@",arr);
    if(arr.count == 3){
        date = [arr objectAtIndex:1];
        month = [arr objectAtIndex:0];
        year = [arr objectAtIndex:2];
    }
    
    //dateFormatter.dateStyle = .medium //ไม่ใช้แล้ว
    //dateFormatter.timeStyle = .none //ไม่ใช้แล้ว
    
//    let somedateString = dateFormatter.stringFromDate(sender.date)
    
//    print(somedateString)  // "somedateString" is your string date
    
    [self calculateLuckana];
}

-(NSString *)fineNameStarFromIndex:(int)i{
    return [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StarPlist" ofType:@"plist"]] objectAtIndex:i+1];
}

-(NSString *)findDegree:(int)degree{
    NSMutableArray *arrTime = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"timePlist" ofType:@"plist"]];
    int i = 0;
    if(degree <= 30){
        i = 0;
    }else if(degree <= 60){
        i = 1;
    }else if(degree <= 90){
        i = 2;
    }else if(degree <= 120){
        i = 3;
    }else if(degree <= 150){
        i = 4;
    }else if(degree <= 180){
        i = 5;
    }else if(degree <= 210){
        i = 6;
    }else if(degree <= 240){
        i = 7;
    }else if(degree <= 270){
        i = 8;
    }else if(degree <= 300){
        i = 9;
    }else if(degree <= 330){
        i = 10;
    }else if(degree <= 360){
        i = 11;
    }

    NSString *time = [arrTime objectAtIndex:i];
    int degree_in = ((i * 30 ) + 30) - degree;
    NSLog(@"องศาที่เหลือ %d",degree_in);
    // หักองศาออกจากนาที
    double total = ((degree_in/30.0) * time.doubleValue);
    NSLog(@"นาทีที่เหลือ %f",total);
    [arrTime replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%f",total]];
    int minute = (b_hour.intValue * 60);
    minute += b_minute.intValue;
    NSLog(@"%d",minute);
    
    
    int num = 0;
    for(int j=0;j<12;j++){
        num = [[arrTime objectAtIndex:i] intValue];
        minute -= num;
        if(minute <= 0){
            NSLog(@"stop i = %d miniute = %d",i,minute);
            break;
        }else{
            NSLog(@"i = %d ==== %@",i,[arrTime objectAtIndex:i]);
        }
        i++;
        if(i>11) i = 0;
    }
    NSLog(@"ลัขนา == %d",i);
    return [NSString stringWithFormat:@"%d",i];
}
#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.tblCountry) return arrTimezone.count;
    return arrZone.count;
//    if(dictCountry){
//        NSPredicate *pre = [NSPredicate predicateWithFormat:@"country_id.intValue == %d",[[dictCountry objectForKey:@"country_id"] intValue]];
//        return [arrState filteredArrayUsingPredicate:pre].count;
//    }
//    return arrState.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTableViewCell"];
    if(tableView == self.tblCountry){
        NSDictionary *dict = [arrTimezone objectAtIndex:indexPath.row];
        cell.lblText.text = [dict objectForKey:@"text"];
    }else{
        cell.lblText.text = [arrZone objectAtIndex:indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.tblCountry){
        dictCountry = [arrTimezone objectAtIndex:indexPath.row];
        [arrZone removeAllObjects];
        [arrZone addObjectsFromArray:[dictCountry objectForKey:@"utc"]];
        
        if(arrZone.count == 1){
            [self.txtCity setText:[arrZone objectAtIndex:0]];
        }else{
            [self.txtCity setText:@""];
        }
        timezone = [NSString stringWithFormat:@"%zd",[[dictCountry objectForKey:@"offset"] integerValue]];
        
        [self.txtCountry setText:[dictCountry objectForKey:@"text"]];
        [self.tblCountry setFrame:CGRectMake(self.tblCountry.frame.origin.x, self.tblCountry.frame.origin.y, self.tblCountry.frame.size.width, 0)];
        [self.tblCity reloadData];
    }else{
        [self.txtCity setText:[arrZone objectAtIndex:indexPath.row]];
        [self.tblCity setFrame:CGRectMake(self.tblCity.frame.origin.x, self.tblCity.frame.origin.y, self.tblCity.frame.size.width, 0)];
    }
}

#pragma mark - Textfiled
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == self.txtCity && !dictCountry) return NO;
    [UIView animateWithDuration:0.1f animations:^{
        if(textField == self.txtCountry){
            [self.tblCountry setFrame:CGRectMake(self.tblCountry.frame.origin.x, self.tblCountry.frame.origin.y, self.tblCountry.frame.size.width, (self.tblCountry.frame.size.height > 0 ? 0 : HEIGHT_TABLE_VIEW))];
        }
        else if(textField == self.txtCity){
            [self.tblCity setFrame:CGRectMake(self.tblCity.frame.origin.x, self.tblCity.frame.origin.y, self.tblCity.frame.size.width, (self.tblCity.frame.size.height > 0 ? 0 : ((self->arrZone.count * 30 > HEIGHT_TABLE_VIEW) ? HEIGHT_TABLE_VIEW : arrZone.count * 30)))];
        }
    }];
    
    return NO;
}

#pragma mark - PickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return 24;
            break;
        case 1:
            return 60;
        case 2:
            return 60;
        default:
            return 0;
    }
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return pickerView.frame.size.width/3.0f;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return [NSString stringWithFormat:@"%02zd",row];
        case 1:
            return [NSString stringWithFormat:@"%02zd",row];
        case 2:
            return [NSString stringWithFormat:@"%02zd",row];
        default:
            return @"";
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0){
        hour = [NSString stringWithFormat:@"%02zd",row];
    }else if(component == 1){
        mininute = [NSString stringWithFormat:@"%02zd",row];
    }else if(component == 2){
        second = [NSString stringWithFormat:@"%02zd",row];
    }
}
-(NSString *)getUniqueCode{
    NSString *letters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:3];
    
    for (int i=0; i<3; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    
    return [NSString stringWithFormat:@"%@%@",[self getDateIngregorianCalendar:@"yyyyMMddHHmmss"],randomString];
}
-(NSString *)getDateIngregorianCalendar:(NSString *)dateFormatter{
    NSDate *now = [NSDate date];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:enUSPOSIXLocale];
    [formatter setDateFormat:dateFormatter];
    [formatter setCalendar:gregorianCalendar];
    return [formatter stringFromDate:now];
}
@end
