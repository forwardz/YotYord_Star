//
//  HeaderPointObject.m
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 17/8/2561 BE.
//  Copyright © 2561 Tutchavee Pongsapisuth. All rights reserved.
//
#define KEYCACHEHEADERPOINT   @"KEYCACHEQUICKTEXT"
#define KEYCACHEHEADERPOINT2   @"KEYCACHEQUICKTEXT2"

#import "HeaderPointObject.h"

@implementation HeaderPointObject


static NSMutableArray *shareHeaderPoint;
static NSMutableArray *shareHeaderPoint2;

+(NSMutableArray *)shareHeaderPoint{
    if (!shareHeaderPoint) {
        shareHeaderPoint = [HeaderPointObject getHeaderPointArrayFromCache];
        if (!shareHeaderPoint) {
            shareHeaderPoint = [[NSMutableArray alloc] init];
        }
    }
    return shareHeaderPoint;
}
+(NSMutableArray *)shareHeaderPoint2{
    if (!shareHeaderPoint2) {
        shareHeaderPoint2 = [HeaderPointObject getHeaderPoint2ArrayFromCache];
        if (!shareHeaderPoint2) {
            shareHeaderPoint2 = [[NSMutableArray alloc] init];
        }
    }
    return shareHeaderPoint2;
}

+(void)refreshHeaderPointArray{
    shareHeaderPoint = [HeaderPointObject getHeaderPointArrayFromCache];
}
+(void)refreshHeaderPoint2Array{
    shareHeaderPoint2 = [HeaderPointObject getHeaderPoint2ArrayFromCache];
}

+(void)createHeaderPointArray{
    NSMutableArray *arr = [NSMutableArray array];
    for(NSDictionary *dict in [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HeaderPoint" ofType:@"plist"]]){
        HeaderPointObject *hpo = [[HeaderPointObject alloc]init];
        hpo.name = [dict objectForKey:@"name"];
        hpo.point = [[dict objectForKey:@"point"] integerValue];
        hpo.recipe = [[dict objectForKey:@"recipe"] integerValue];
        if([dict objectForKey:@"is_weak_star"]){
            hpo.isWeakStar = YES;
        }
        hpo.arrPredict = [NSMutableArray arrayWithArray:[dict objectForKey:@"arrPredict"]];
        [arr addObject:hpo];
    }
    shareHeaderPoint = [NSMutableArray arrayWithArray:arr];
    [HeaderPointObject cacheHeaderPoint];
}

+(void)createHeaderPoint2Array{
    NSMutableArray *arr = [NSMutableArray array];
    for(NSDictionary *dict in [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HeaderPoint2" ofType:@"plist"]]){
        HeaderPointObject *hpo = [[HeaderPointObject alloc]init];
        hpo.name = [dict objectForKey:@"name"];
        hpo.point = [[dict objectForKey:@"point"] integerValue];
        hpo.recipe = [[dict objectForKey:@"recipe"] integerValue];
        if([dict objectForKey:@"is_weak_star"]){
            hpo.isWeakStar = YES;
        }
        hpo.arrPredict = [NSMutableArray arrayWithArray:[dict objectForKey:@"arrPredict"]];
        [arr addObject:hpo];
    }
    shareHeaderPoint2 = [NSMutableArray arrayWithArray:arr];
    [HeaderPointObject cacheHeaderPoint2];
}

//+(void)createQuickTextObjectWithArray:(NSDictionary *)dic{
//    NSMutableArray *newarray = [NSMutableArray array];
//    for (NSDictionary *dict in [dic objectForKey:@"void_list"]) {
//        [newarray addObject:[QuickTextObject createQuickTextObjectWithDictionary:dict]];
//    }
//
//    NSMutableArray *newarray2 = [NSMutableArray array];
//    for (NSDictionary *dict in [dic objectForKey:@"cancel_list"]) {
//        [newarray2 addObject:[QuickTextObject createQuickTextObjectWithDictionary:dict]];
//    }
//
//    NSMutableArray *newarray3 = [NSMutableArray array];
//    for (NSDictionary *dict in [dic objectForKey:@"discount_list"]) {
//        [newarray3 addObject:[QuickTextObject createQuickTextObjectWithDictionary:dict]];
//    }
//
//    shareQuickText = [NSMutableDictionary dictionary];
//    [shareQuickText setObject:newarray forKey:@"void_list"];
//    [shareQuickText setObject:newarray2 forKey:@"cancel_list"];
//    [shareQuickText setObject:newarray3 forKey:@"discount_list"];
//    [QuickTextObject cacheQuickText];
//}

//+(QuickTextObject *)createQuickTextObjectWithDictionary:(NSDictionary *)dict{
//    QuickTextObject *qto = [[QuickTextObject alloc]init];
//    qto.quick_text_id = [[dict objectForKey:@"quick_text_id"] integerValue];
//    qto.quick_text = [dict objectForKey:@"quick_text"];
//    qto.isSelected = NO;
//    return qto;
//}


+(void)cacheHeaderPoint{
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:shareHeaderPoint];
    [[NSUserDefaults standardUserDefaults] setObject:myEncodedObject forKey:KEYCACHEHEADERPOINT];
}
+(void)cacheHeaderPoint2{
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:shareHeaderPoint2];
    [[NSUserDefaults standardUserDefaults] setObject:myEncodedObject forKey:KEYCACHEHEADERPOINT2];
}

+(void)cacheHeaderPoint:(NSMutableArray *)array{
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:array];
    [[NSUserDefaults standardUserDefaults] setObject:myEncodedObject forKey:KEYCACHEHEADERPOINT];
}

+(void)cacheHeaderPoint2:(NSMutableArray *)array{
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:array];
    [[NSUserDefaults standardUserDefaults] setObject:myEncodedObject forKey:KEYCACHEHEADERPOINT2];
}

+(NSMutableArray *)getHeaderPointArrayFromCache{
    NSData *myDecodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:KEYCACHEHEADERPOINT];
    if (myDecodedObject) {
        return (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:myDecodedObject];
    }
    return nil;
}

+(NSMutableArray *)getHeaderPoint2ArrayFromCache{
    NSData *myDecodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:KEYCACHEHEADERPOINT2];
    if (myDecodedObject) {
        return (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:myDecodedObject];
    }
    return nil;
}
-(id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if (self){
        self.name = [decoder decodeObjectForKey:@"name"];
        self.point = [[decoder decodeObjectForKey:@"asc"] integerValue];
        self.recipe = [[decoder decodeObjectForKey:@"recipe"] integerValue];
        self.arrPredict = [decoder decodeObjectForKey:@"arrPredict"];
        self.isWeakStar = [[decoder decodeObjectForKey:@"isWeakStar"] boolValue];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    if (self.name) [encoder encodeObject:self.name forKey:@"name"];
    if (self.point) [encoder encodeObject:[NSNumber numberWithInteger:self.point] forKey:@"point"];
    if (self.recipe) [encoder encodeObject:[NSNumber numberWithBool:self.recipe] forKey:@"recipe"];
    if (self.arrPredict) [encoder encodeObject:self.arrPredict forKey:@"arrPredict"];
    if (self.isWeakStar) [encoder encodeObject:[NSNumber numberWithBool:self.isWeakStar] forKey:@"isWeakStar"];
}
@end


@implementation StarReportObject

+(NSArray *)createStarReportArray{
    NSMutableArray *array = [NSMutableArray array];
    for(NSArray *arrStar in [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StarReportPlist" ofType:@"plist"]]){
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in arrStar){
            StarReportObject *sro = [[StarReportObject alloc]init];
            sro.name = [dict objectForKey:@"name"];
            sro.arrPoint = [NSMutableArray array];
            for(NSDictionary *dicts in [dict objectForKey:@"arrPoint"]){
                StarSubObject *sso = [[StarSubObject alloc] init];
                sso.star = [[dicts objectForKey:@"star"] integerValue];
                sso.sign = [[dicts objectForKey:@"point"] integerValue];
                [sro.arrPoint addObject:sso];
            }
            [arr addObject:sro];
        }
        [array addObject:arr];
    }
    return array;
}

-(id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if (self){
        self.name = [decoder decodeObjectForKey:@"name"];
        self.arrPoint = [decoder decodeObjectForKey:@"arrPoint"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    if (self.name) [encoder encodeObject:self.name forKey:@"name"];
    if (self.arrPoint) [encoder encodeObject:self.arrPoint forKey:@"arrPoint"];
}
@end

@implementation StarSubObject


-(id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if (self){
        self.star = [[decoder decodeObjectForKey:@"star"] integerValue];
        self.sign = [[decoder decodeObjectForKey:@"sign"] integerValue];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    if (self.star) [encoder encodeObject:[NSNumber numberWithInteger:self.star] forKey:@"star"];
    if (self.sign) [encoder encodeObject:[NSNumber numberWithInteger:self.sign] forKey:@"sign"];
}
@end
