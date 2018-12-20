//
//  RasiObject.m
//  testjs
//
//  Created by Tutchavee Pongsapisuth on 7/28/2560 BE.
//  Copyright © 2560 Tutchavee Pongsapisuth. All rights reserved.
//

#import "RasiObject.h"

@implementation RasiObject
+(RasiObject *)createRasiObject:(NSString *)rasi withOngsa:(NSString *)ongsa withLipda:(NSString *)lipda withName:(NSString *)name{
    RasiObject *ro = [[RasiObject alloc]init];
    ro.name = name;
    ro.rasi = rasi;
    ro.ongsa = ongsa;
    ro.lipda = lipda;
    return ro;
}
@end


@implementation DateRasiObject

+(DateRasiObject *)createDate:(int)d :(int)m :(int)y :(int)h :(int)mi :(int)s :(int)z{
    DateRasiObject *dto = [[DateRasiObject alloc]init];
    dto.date = [NSString stringWithFormat:@"%d",d];
    dto.month = [NSString stringWithFormat:@"%d",m];
    dto.year = [NSString stringWithFormat:@"%d",y];
    dto.hour = [NSString stringWithFormat:@"%d",h];
    dto.minute = [NSString stringWithFormat:@"%d",mi];
    dto.second = [NSString stringWithFormat:@"%d",s];
    dto.zone = [NSString stringWithFormat:@"%d",z];
    return dto;
}

@end


@implementation ResultObject



@end
