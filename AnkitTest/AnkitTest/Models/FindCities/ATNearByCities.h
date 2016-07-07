//
//  ATNearByCities.h
//
//  Created by Ankit Gohel on 29/06/16
//  Copyright (c) 2016 Netwin Infosolutions. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ATNearByCities : NSObject <NSCoding, NSCopying>

/**
 *  Message From API
 */
@property (nonatomic, strong) NSString *message;
/**
 *  Code from API
 */
@property (nonatomic, strong) NSString *cod;
/**
 *  Count of records returned
 */
@property (nonatomic, assign) double count;
/**
 *  Array of objects being returned
 */
@property (nonatomic, strong) NSArray *list;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
