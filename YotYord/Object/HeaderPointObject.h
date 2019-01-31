//
//  HeaderPointObject.h
//  YotYord
//
//  Created by Tutchavee Pongsapisuth on 17/8/2561 BE.
//  Copyright © 2561 Tutchavee Pongsapisuth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderPointObject : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) NSInteger point;
@property (nonatomic, assign) NSInteger recipe;
@property (nonatomic, assign) BOOL isWeakStar;
@property (nonatomic, retain) NSMutableArray *arrPredict;

+(NSMutableArray *)shareHeaderPoint;
+(NSMutableArray *)shareHeaderPoint2;
+(void)createHeaderPointArray;
+(void)createHeaderPoint2Array;
@end

@interface StarReportObject : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableArray *arrPoint;
@property (nonatomic, assign) BOOL isWeakStar;
+(NSArray *)createStarReportArray;
@end


@interface StarSubObject : NSObject
@property (nonatomic, assign) NSInteger star;
@property (nonatomic, assign) NSInteger sign;
@end
