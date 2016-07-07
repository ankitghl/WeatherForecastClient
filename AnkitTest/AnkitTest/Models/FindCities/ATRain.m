//
//  ATRain.m
//
//  Created by Ankit Gohel on 29/06/16
//  Copyright (c) 2016 Netwin Infosolutions. All rights reserved.
//

#import "ATRain.h"


NSString *const kATRain3h = @"h3";


@interface ATRain ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ATRain

@synthesize h3 = _h3;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.h3 = [[self objectOrNilForKey:kATRain3h fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.h3] forKey:kATRain3h];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.h3 = [aDecoder decodeDoubleForKey:kATRain3h];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_h3 forKey:kATRain3h];
}

- (id)copyWithZone:(NSZone *)zone
{
    ATRain *copy = [[ATRain alloc] init];
    
    if (copy) {

        copy.h3 = self.h3;
    }
    
    return copy;
}


@end
