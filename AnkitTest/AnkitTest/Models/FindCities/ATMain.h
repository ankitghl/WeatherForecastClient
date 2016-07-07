//
//  ATMain.h
//
//  Created by Ankit Gohel on 29/06/16
//  Copyright (c) 2016 Netwin Infosolutions. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ATMain : NSObject <NSCoding, NSCopying>

/**
 *  stores humidity
 */
@property (nonatomic, assign) double humidity;
/**
 *  stores tempMin
 */
@property (nonatomic, assign) double tempMin;
/**
 *  stores tempMax
 */
@property (nonatomic, assign) double tempMax;
/**
 *  stores temp
 */
@property (nonatomic, assign) double temp;
/**
 *  stores pressure
 */
@property (nonatomic, assign) double pressure;
/**
 *  stores grndLevel
 */
@property (nonatomic, assign) double grndLevel;
/**
 *  stores seaLevel
 */
@property (nonatomic, assign) double seaLevel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
