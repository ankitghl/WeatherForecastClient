//
//  ATTemp.h
//
//  Created by Prateek Jain on 30/06/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ATTemp : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double night;
@property (nonatomic, assign) double min;
@property (nonatomic, assign) double eve;
@property (nonatomic, assign) double day;
@property (nonatomic, assign) double max;
@property (nonatomic, assign) double morn;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
