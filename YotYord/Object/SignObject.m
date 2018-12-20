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
        self.minute = [decoder decodeObjectForKey:@"minute"] ;
        self.second = [decoder decodeObjectForKey:@"second"];
        self.zone = [decoder decodeObjectForKey:@"zone"];
        
//        self.asc = [decoder decodeObjectForKey:@"asc"];
//        self.one = [decoder decodeObjectForKey:@"one"];
//        self.two = [decoder decodeObjectForKey:@"two"];
//        self.three = [decoder decodeObjectForKey:@"three"];
//        self.four = [decoder decodeObjectForKey:@"four"];
//        self.five = [decoder decodeObjectForKey:@"five"];
//        self.six = [decoder decodeObjectForKey:@"six"];
//        self.seven = [decoder decodeObjectForKey:@"seven"];
//        self.eight = [decoder decodeObjectForKey:@"eight"];
//        self.nine = [decoder decodeObjectForKey:@"nine"];
//        self.zero = [decoder decodeObjectForKey:@"zero"];
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