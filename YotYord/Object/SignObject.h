//
//  SignObject.h
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 17/8/2561 BE.
//  Copyright © 2561 Tutchavee Pongsapisuth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignObject : NSObject

+(NSMutableArray *)shareSignObject;
+(void)refreshSign;
+(NSMutableArray *)getSignArrayFromCache;
+(void)cacheSignObjectToCache;


@property (nonatomic, retain) NSString *s_id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSDate *pure_date;
@property (nonatomic, retain) NSString *month;
@property (nonatomic, retain) NSString *year;
@property (nonatomic, retain) NSString *hour;
@property (nonatomic, retain) NSString *minute;
@property (nonatomic, retain) NSString *second;
@property (nonatomic, retain) NSString *zone;
@property (nonatomic, assign) NSInteger luckana;
@property (nonatomic, retain) NSMutableArray *arrStarSign;
@property (nonatomic, retain) NSMutableArray *arrStarSign2;
@end

@interface SignIndexObject : NSObject
@property (nonatomic, assign) NSInteger star;
@property (nonatomic, assign) NSInteger sign;
@end


