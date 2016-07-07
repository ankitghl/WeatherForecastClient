//
//  ATList.h
//
//  Created by Ankit Gohel on 29/06/16
//  Copyright (c) 2016 Netwin Infosolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ATWind, ATRain, ATCoord, ATClouds, ATMain, ATSys;

@interface ATList : NSObject <NSCoding, NSCopying>

/**
 *  Object of ATWind to store related info
 */
@property (nonatomic, strong) ATWind *wind;
/**
 *  Object of ATRain to store related info
 */
@property (nonatomic, strong) ATRain *rain;
/**
 *  stores Timestamp
 */
@property (nonatomic, assign) double dt;
/**
 *  soters list ID
 */
@property (nonatomic, assign) double listIdentifier;
/**
 *  Object of ATCoord to store related info
 */
@property (nonatomic, strong) ATCoord *coord;
/**
 *  Object of ATClouds to store related info
 */
@property (nonatomic, strong) ATClouds *clouds;
/**
 *  Object of ATMain to store related info
 */
@property (nonatomic, strong) ATMain *main;
/**
 *  stores array of weather objects
 */
@property (nonatomic, strong) NSArray *weather;
/**
 *  Object of ATSys to store related info
 */
@property (nonatomic, strong) ATSys *sys;
/**
 *  gives name of place
 */
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
