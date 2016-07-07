//
//  ATList.h
//
//  Created by Prateek Jain on 30/06/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ATTemp;

@interface ATListForecast : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double clouds;
@property (nonatomic, assign) double humidity;
@property (nonatomic, assign) double rain;
@property (nonatomic, assign) double speed;
@property (nonatomic, assign) double dt;
@property (nonatomic, assign) double pressure;
@property (nonatomic, strong) ATTemp *temp;
@property (nonatomic, strong) NSArray *weather;
@property (nonatomic, assign) double deg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
