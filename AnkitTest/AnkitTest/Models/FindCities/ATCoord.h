//
//  ATCoord.h
//
//  Created by Ankit Gohel on 29/06/16
//  Copyright (c) 2016 Netwin Infosolutions. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ATCoord : NSObject <NSCoding, NSCopying>

/**
 *  stores latitiude of location
 */
@property (nonatomic, assign) double lon;
/**
 *  stores longitude of location
 */
@property (nonatomic, assign) double lat;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
