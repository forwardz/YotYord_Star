
//
//  PopupInputSignViewController.m
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 17/8/2561 BE.
//  Copyright © 2561 Tutchavee Pongsapisuth. All rights reserved.
//

#import "PopupInputSignViewController.h"

@interface PopupInputSignViewController ()

@end

@implementation PopupInputSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)saveAction:(id)sender{
    SignObject *so = [[SignObject alloc] init];
    so.name = self.txtName.text;
    so.arrStarSign = [NSMutableArray array];
    
    SignIndexObject *sio = [self createSignIndexObject:-1 withSign:self.txtAsc.text];
    [so.arrStarSign addObject:sio];
    so.luckana = sio.sign;
    [so.arrStarSign addObject:[self createSignIndexObject:1 withSign:self.txt1.text]];
    [so.arrStarSign addObject:[self createSignIndexObject:2 withSign:self.txt2.text]];
    [so.arrStarSign addObject:[self createSignIndexObject:3 withSign:self.txt3.text]];
    [so.arrStarSign addObject:[self createSignIndexObject:4 withSign:self.txt4.text]];
    [so.arrStarSign addObject:[self createSignIndexObject:5 withSign:self.txt5.text]];
    [so.arrStarSign addObject:[self createSignIndexObject:6 withSign:self.txt6.text]];
    [so.arrStarSign addObject:[self createSignIndexObject:7 withSign:self.txt7.text]];
    [so.arrStarSign addObject:[self createSignIndexObject:8 withSign:self.txt8.text]];
    [so.arrStarSign addObject:[self createSignIndexObject:9 withSign:self.txt9.text]];
    [so.arrStarSign addObject:[self createSignIndexObject:0 withSign:self.txt0.text]];
    [self calculateNewSign:so];
//    NSLog(@"%@",so.arrStarSign2);
    if([self.delegate respondsToSelector:@selector(saveSignObjectFidnish:)]){
        [self.delegate saveSignObjectFidnish:so];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
            [arr addObject:[NSNumber numberWithInteger:sio.star]];
        }
        [so.arrStarSign2 addObject:arr];
    }
}

@end
