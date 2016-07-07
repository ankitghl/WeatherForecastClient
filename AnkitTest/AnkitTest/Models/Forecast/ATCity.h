//
//  ATCity.h
//
//  Created by Prateek Jain on 30/06/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ATCoord;

@interface ATCity : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double cityIdentifier;
@property (nonatomic, strong) ATCoord *coord;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double population;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
