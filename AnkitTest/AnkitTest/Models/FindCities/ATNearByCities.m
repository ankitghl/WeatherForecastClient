//
//  ATNearByCities.m
//
//  Created by Ankit Gohel on 29/06/16
//  Copyright (c) 2016 Netwin Infosolutions. All rights reserved.
//

#import "ATNearByCities.h"
#import "ATList.h"


NSString *const kATNearByCitiesMessage = @"message";
NSString *const kATNearByCitiesCod = @"cod";
NSString *const kATNearByCitiesCount = @"count";
NSString *const kATNearByCitiesList = @"list";


@interface ATNearByCities ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ATNearByCities

@synthesize message = _message;
@synthesize cod = _cod;
@synthesize count = _count;
@synthesize list = _list;

/**
 *  Gives Object from given Dictionary
 *
 *  @param dict Dictionary from JSON response from API
 *
 *  @return Instnce of class with all properties
 */
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

/**
 *  Initialise the Model object by dictionary
 *
 *  @param dict Dictionary from JSON response from API
 *
 *  @return Instnce of class with all properties
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.message = [self objectOrNilForKey:kATNearByCitiesMessage fromDictionary:dict];
        self.cod = [self objectOrNilForKey:kATNearByCitiesCod fromDictionary:dict];
        self.count = [[self objectOrNilForKey:kATNearByCitiesCount fromDictionary:dict] doubleValue];
        NSObject *receivedATList = [dict objectForKey:kATNearByCitiesList];
        
        NSMutableArray *parsedATList = [NSMutableArray array];
        if ([receivedATList isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedATList) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedATList addObject:[ATList modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedATList isKindOfClass:[NSDictionary class]]) {
            [parsedATList addObject:[ATList modelObjectWithDictionary:(NSDictionary *)receivedATList]];
        }
        
        self.list = [NSArray arrayWithArray:parsedATList];
        
    }
    
    return self;
    
}

/**
 *  Sets key value pair of Dictionary
 *
 *  @return Dictionary formated
 */
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kATNearByCitiesMessage];
    [mutableDict setValue:self.cod forKey:kATNearByCitiesCod];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kATNearByCitiesCount];
    NSMutableArray *tempArrayForList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.list) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForList] forKey:kATNearByCitiesList];
    
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
    
    self.message = [aDecoder decodeObjectForKey:kATNearByCitiesMessage];
    self.cod = [aDecoder decodeObjectForKey:kATNearByCitiesCod];
    self.count = [aDecoder decodeDoubleForKey:kATNearByCitiesCount];
    self.list = [aDecoder decodeObjectForKey:kATNearByCitiesList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_message forKey:kATNearByCitiesMessage];
    [aCoder encodeObject:_cod forKey:kATNearByCitiesCod];
    [aCoder encodeDouble:_count forKey:kATNearByCitiesCount];
    [aCoder encodeObject:_list forKey:kATNearByCitiesList];
}

- (id)copyWithZone:(NSZone *)zone
{
    ATNearByCities *copy = [[ATNearByCities alloc] init];
    
    if (copy) {
        
        copy.message = [self.message copyWithZone:zone];
        copy.cod = [self.cod copyWithZone:zone];
        copy.count = self.count;
        copy.list = [self.list copyWithZone:zone];
    }
    
    return copy;
}


@end
