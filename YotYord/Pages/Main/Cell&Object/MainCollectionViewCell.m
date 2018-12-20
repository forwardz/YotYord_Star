//
//  MainCollectionViewCell.m
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 23/8/2561 BE.
//  Copyright © 2561 Tutchavee Pongsapisuth. All rights reserved.
//

#import "MainCollectionViewCell.h"
#define BLUE_COLOR   [UIColor colorWithRed:203/255.0f green:240/255.0f blue:255/255.0f alpha:1.0]

@implementation MainCollectionViewCell
-(void)awakeFromNib{
    [super awakeFromNib];
    [self.lblHeader setTransform:CGAffineTransformMakeRotation(M_PI*1.5)];
}
//-(void)setDataCollectionCell:(HeaderPointObject *)hpo withSignObject:(SignObject *)so withType:(NSInteger)type{
//    signObject = so;
//    headerPointObject = hpo;
//    typeTable = type;
//    [self.lblHeader setText:hpo.name];
//    [self.tblData reloadData];
//}
-(void)setDataCollectionCell:(StarReportObject *)sro withSignObject:(SignObject *)so withType:(NSInteger)type{
    signObject = so;
    starReportObject = sro;
    typeTable = type;
    [self.lblHeader setText:sro.name];
    [self.tblData reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return starReportObject.arrPoint.count;
//    return headerPointObject.arrPredict.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainTableViewCell"];
    [cell setBackgroundColor:[UIColor whiteColor]];
    StarSubObject *sso = [starReportObject.arrPoint objectAtIndex:indexPath.row];
    if(sso.sign > 0){
        [cell setBackgroundColor:BLUE_COLOR];
    }else{
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    /*
    if(typeTable == 1){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            HeaderPointObject *hd = self->headerPointObject;
            SignObject *so = self->signObject;
            NSMutableArray *arr = [so.arrStarSign2  objectAtIndex:indexPath.row];
            NSString *predict = [hd.arrPredict objectAtIndex:indexPath.row];
            if(predict.length){
                NSPredicate *predicate;
                if(hd.recipe == 1){
                    predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@",predict]];
                    if([arr filteredArrayUsingPredicate:predicate].count){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [cell setBackgroundColor:BLUE_COLOR];
                        });
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [cell setBackgroundColor:[UIColor clearColor]];
                        });
                    }
                }
                else if(hd.recipe == 3){
                    NSArray *items = [predict componentsSeparatedByString:@","];
                    if(items.count > 0){
                        for(NSString *sub_predict in items){
                            predicate = [NSPredicate predicateWithFormat:sub_predict];
                            if([arr filteredArrayUsingPredicate:predicate].count){
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [cell setBackgroundColor:BLUE_COLOR];
                                });
                            }else{
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [cell setBackgroundColor:[UIColor clearColor]];
                                });
                                break;
                            }
                        }
                    }
                }
                
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [cell setBackgroundColor:[UIColor whiteColor]];
                });
            }
        });
    }else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            HeaderPointObject *hd = self->headerPointObject;
            SignObject *so = self->signObject;
            NSString *predict = [hd.arrPredict objectAtIndex:indexPath.row];
            if(predict.length){
                NSPredicate *predicate;
                if(hd.recipe == 0){
                    predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ && sign == %zd",predict,indexPath.row]];
                    if([so.arrStarSign filteredArrayUsingPredicate:predicate].count){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [cell setBackgroundColor:BLUE_COLOR];
                        });
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [cell setBackgroundColor:[UIColor clearColor]];
                        });
                    }
                }
                else if(hd.recipe == 1) {
                    NSArray *items = [predict componentsSeparatedByString:@","];
                    BOOL bo = NO;
                    // OR
                    for(NSString *sub_predict in items){
                        predicate = [NSPredicate predicateWithFormat:sub_predict];
                        if([so.arrStarSign filteredArrayUsingPredicate:predicate].count){
                            bo = YES;
                        }else{
                            bo = NO;
                        }
                    }
                    if(bo){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [cell setBackgroundColor:BLUE_COLOR];
                        });
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [cell setBackgroundColor:[UIColor clearColor]];
                        });
                    }
                }else if(hd.recipe == 2){
                    predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@",predict]];
                    if([so.arrStarSign filteredArrayUsingPredicate:predicate].count){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [cell setBackgroundColor:BLUE_COLOR];
                        });
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [cell setBackgroundColor:[UIColor clearColor]];
                        });
                    }
                }
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [cell setBackgroundColor:[UIColor clearColor]];
                });
                
            }
            
        });
    }
     */
    return cell;
    
}
/*
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainTableViewCell"];
    [cell setBackgroundColor:[UIColor whiteColor]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        HeaderPointObject *hd = self->headerPointObject;
        SignObject *so = self->signObject;
        NSString *predict = [hd.arrPredict objectAtIndex:indexPath.row];
        if(predict.length){
            NSPredicate *predicate;
            if(hd.recipe == 0){
                predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ && sign == %zd",predict,indexPath.row]];
                if([so.arrStarSign filteredArrayUsingPredicate:predicate].count){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [cell setBackgroundColor:[UIColor greenColor]];
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [cell setBackgroundColor:[UIColor whiteColor]];
                    });
                }
            }
            else if(hd.recipe == 1) {
                NSArray *items = [predict componentsSeparatedByString:@","];
                BOOL bo = NO;
                // OR
                for(NSString *sub_predict in items){
                    predicate = [NSPredicate predicateWithFormat:sub_predict];
                    if([so.arrStarSign filteredArrayUsingPredicate:predicate].count){
                        bo = YES;
                    }else{
                        bo = NO;
                    }
                }
                if(bo){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [cell setBackgroundColor:[UIColor greenColor]];
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [cell setBackgroundColor:[UIColor whiteColor]];
                    });
                }
            }else if(hd.recipe == 2){
                predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@",predict]];
                if([so.arrStarSign filteredArrayUsingPredicate:predicate].count){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [cell setBackgroundColor:[UIColor greenColor]];
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [cell setBackgroundColor:[UIColor whiteColor]];
                    });
                }
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell setBackgroundColor:[UIColor whiteColor]];
            });
            
        }
        
    });
    
   
    
    return cell;
}
 */
@end
