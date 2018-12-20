//
//  RasiObject.h
//  testjs
//
//  Created by Tutchavee Pongsapisuth on 7/28/2560 BE.
//  Copyright © 2560 Tutchavee Pongsapisuth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RasiObject : NSObject
@property (nonatomic, retain) NSString *name,*rasi,*ongsa,*lipda;
+(RasiObject *)createRasiObject:(NSString *)rasi withOngsa:(NSString *)ongsa withLipda:(NSString *)lipda withName:(NSString *)name;
@end


@interface DateRasiObject : NSObject{
    
}
@property (nonatomic,retain) NSString *date,*month,*year,*hour,*minute,*second,*zone;
+(DateRasiObject *)createDate:(int)d :(int)m :(int)y :(int)h :(int)mi :(int)s :(int)z;

@end



@interface ResultObject : NSObject
@property (nonatomic,retain) DateRasiObject *dateRasiObject;
@property (nonatomic,retain) NSMutableArray *arrRasi;

@end
