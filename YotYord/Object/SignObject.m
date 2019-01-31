//
//  SignObject.m
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 17/8/2561 BE.
//  Copyright © 2561 Tutchavee Pongsapisuth. All rights reserved.
//

#import "SignObject.h"

@implementation SignObject

static NSMutableArray *shareSignObejct;

+(NSMutableArray *)shareSignObject{
    if (!shareSignObejct) {
        shareSignObejct = [SignObject getSignArrayFromCache];
        if (!shareSignObejct) {
            shareSignObejct = [[NSMutableArray alloc] init];
        }
    }
    return shareSignObejct;
}

+(void)refreshSign{
    shareSignObejct = [SignObject getSignArrayFromCache];
}

+(void)cacheSignObjectToCache{
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:shareSignObejct];
    [[NSUserDefaults standardUserDefaults] setObject:myEncodedObject forKey:@"KEYCAHCESIGNOBJECT"];
}

+(NSMutableArray *)getSignArrayFromCache{
    NSData *myDecodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"KEYCAHCESIGNOBJECT"];
    if (myDecodedObject) {
        return (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:myDecodedObject];
    }
    return nil;
}


-(id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if (self){
        self.s_id = [decoder decodeObjectForKey:@"s_id"];
        self.arrStarSign = [decoder decodeObjectForKey:@"arrStarSign"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.luckana = [[decoder decodeObjectForKey:@"luckana"] integerValue];
        self.arrStarSign2 = [decoder decodeObjectForKey:@"arrStarSign2"];
        
        self.date = [decoder decodeObjectForKey:@"date"];
        self.pure_date = [decoder decodeObjectForKey:@"pure_date"];
        self.month = [decoder decodeObjectForKey:@"month"];
        self.year = [decoder decodeObjectForKey:@"year"];
        self.hour = [decoder decodeObjectForKey:@"hour"] ;
        self.minute = [decoder decodeObjectForKey:@"minute"];
        self.second = [decoder decodeObjectForKey:@"second"];
        self.zone = [decoder decodeObjectForKey:@"zone"];
        
        self.city = [decoder decodeObjectForKey:@"city"];
        self.country = [decoder decodeObjectForKey:@"country"];
        
        self.solidStar = [[decoder decodeObjectForKey:@"solidStar"] intValue];
        self.weakStar = [[decoder decodeObjectForKey:@"weakStar"] intValue];
        self.arrWeight = [decoder decodeObjectForKey:@"arrWeight"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    if (self.s_id) [encoder encodeObject:self.s_id forKey:@"s_id"];
    if (self.arrStarSign) [encoder encodeObject:self.arrStarSign forKey:@"arrStarSign"];
    if (self.name) [encoder encodeObject:self.name forKey:@"name"];
    if (self.luckana) [encoder encodeObject:[NSNumber numberWithInteger:self.luckana] forKey:@"luckana"];
    if (self.arrStarSign2) [encoder encodeObject:self.arrStarSign2 forKey:@"arrStarSign2"];
    
    if(self.date) [encoder encodeObject:self.date forKey:@"date"];
    if (self.pure_date) [encoder encodeObject:self.pure_date forKey:@"pure_date"];
    if(self.month) [encoder encodeObject:self.month forKey:@"month"];
    if(self.year) [encoder encodeObject:self.year forKey:@"year"];
    if(self.hour) [encoder encodeObject:self.hour forKey:@"hour"];
    if(self.minute) [encoder encodeObject:self.minute forKey:@"minute"];
    if(self.second) [encoder encodeObject:self.second forKey:@"second"];
    if(self.zone) [encoder encodeObject:self.zone forKey:@"zone"];
    
    if(self.city) [encoder encodeObject:self.city forKey:@"city"];
    if(self.country) [encoder encodeObject:self.country forKey:@"country"];
    
    if(self.solidStar) [encoder encodeObject:[NSNumber numberWithInt:self.solidStar] forKey:@"solidStar"];
    if(self.weakStar) [encoder encodeObject:[NSNumber numberWithInt:self.weakStar] forKey:@"weakStar"];
    if(self.arrWeight) [encoder encodeObject:self.arrWeight forKey:@"arrWeight"];
//    if (self.asc) [encoder encodeObject:self.asc forKey:@"asc"];
//    if (self.one) [encoder encodeObject:self.one forKey:@"one"];
//    if (self.two) [encoder encodeObject:self.two forKey:@"two"];
//    if (self.three) [encoder encodeObject:self.three forKey:@"three"];
//    if (self.four) [encoder encodeObject:self.four forKey:@"four"];
//    if (self.five) [encoder encodeObject:self.five forKey:@"five"];
//    if (self.six) [encoder encodeObject:self.six forKey:@"six"];
//    if (self.seven) [encoder encodeObject:self.seven forKey:@"seven"];
//    if (self.eight) [encoder encodeObject:self.eight forKey:@"eight"];
//    if (self.nine) [encoder encodeObject:self.nine forKey:@"nine"];
//    if (self.zero) [encoder encodeObject:self.zero forKey:@"zero"];
}
@end


@implementation SignIndexObject
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

@implementation StarShowObject
-(id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if (self){
        self.name = [decoder decodeObjectForKey:@"name"];
        self.weight = [[decoder decodeObjectForKey:@"weight"] integerValue];
        self.point = [[decoder decodeObjectForKey:@"point"] integerValue];
        self.star = [[decoder decodeObjectForKey:@"star"] integerValue];
        self.image_name = [decoder decodeObjectForKey:@"image_name"];
        self.percent = [[decoder decodeObjectForKey:@"percent"] integerValue];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    if (self.name) [encoder encodeObject:self.name forKey:@"name"];
    if (self.weight) [encoder encodeObject:[NSNumber numberWithInteger:self.weight] forKey:@"weight"];
    if (self.point) [encoder encodeObject:[NSNumber numberWithInteger:self.point] forKey:@"point"];
    if (self.star) [encoder encodeObject:[NSNumber numberWithInteger:self.star] forKey:@"star"];
    if (self.image_name) [encoder encodeObject:self.image_name forKey:@"image_name"];
    if (self.percent) [encoder encodeObject:[NSNumber numberWithInteger:self.percent] forKey:@"percent"];
}

+(NSMutableArray *)createStarShowObject{
    NSMutableArray *arr = [NSMutableArray array];
    for(NSDictionary *dict in [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StarShowPlist" ofType:@"plist"]]){
        [arr addObject:[StarShowObject createStarShowObjectWithDictionary:dict]];
    }
    return arr;
}
+(StarShowObject *)createStarShowObjectWithDictionary:(NSDictionary *)dict{
    StarShowObject *sso = [[StarShowObject alloc] init];
    sso.name = [dict objectForKey:@"name"];
    sso.weight = [[dict objectForKey:@"weight"] integerValue];
    sso.point = [[dict objectForKey:@"point"] integerValue];
    sso.star = [[dict objectForKey:@"star"] integerValue];
    sso.image_name = [NSString stringWithFormat:@"%zd",[[dict objectForKey:@"star"] integerValue]];
    sso.percent = 50;
    return sso;
}

@end
