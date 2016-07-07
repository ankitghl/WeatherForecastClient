//
//  ATForecast.m
//
//  Created by Prateek Jain on 30/06/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ATForecast.h"
#import "ATCity.h"
#import "ATListForecast.h"


NSString *const kATForecastMessage = @"message";
NSString *const kATForecastCod = @"cod";
NSString *const kATForecastCity = @"city";
NSString *const kATForecastCnt = @"cnt";
NSString *const kATForecastList = @"list";


@interface ATForecast ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ATForecast

@synthesize message = _message;
@synthesize cod = _cod;
@synthesize city = _city;
@synthesize cnt = _cnt;
@synthesize list = _list;


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
            self.message = [[self objectOrNilForKey:kATForecastMessage fromDictionary:dict] doubleValue];
            self.cod = [self objectOrNilForKey:kATForecastCod fromDictionary:dict];
            self.city = [ATCity modelObjectWithDictionary:[dict objectForKey:kATForecastCity]];
            self.cnt = [[self objectOrNilForKey:kATForecastCnt fromDictionary:dict] doubleValue];
    NSObject *receivedATList = [dict objectForKey:kATForecastList];
    NSMutableArray *parsedATList = [NSMutableArray array];
    if ([receivedATList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedATList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedATList addObject:[ATListForecast modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedATList isKindOfClass:[NSDictionary class]]) {
       [parsedATList addObject:[ATListForecast modelObjectWithDictionary:(NSDictionary *)receivedATList]];
    }

    self.list = [NSArray arrayWithArray:parsedATList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.message] forKey:kATForecastMessage];
    [mutableDict setValue:self.cod forKey:kATForecastCod];
    [mutableDict setValue:[self.city dictionaryRepresentation] forKey:kATForecastCity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cnt] forKey:kATForecastCnt];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForList] forKey:kATForecastList];

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

    self.message = [aDecoder decodeDoubleForKey:kATForecastMessage];
    self.cod = [aDecoder decodeObjectForKey:kATForecastCod];
    self.city = [aDecoder decodeObjectForKey:kATForecastCity];
    self.cnt = [aDecoder decodeDoubleForKey:kATForecastCnt];
    self.list = [aDecoder decodeObjectForKey:kATForecastList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_message forKey:kATForecastMessage];
    [aCoder encodeObject:_cod forKey:kATForecastCod];
    [aCoder encodeObject:_city forKey:kATForecastCity];
    [aCoder encodeDouble:_cnt forKey:kATForecastCnt];
    [aCoder encodeObject:_list forKey:kATForecastList];
}

- (id)copyWithZone:(NSZone *)zone
{
    ATForecast *copy = [[ATForecast alloc] init];
    
    if (copy) {

        copy.message = self.message;
        copy.cod = [self.cod copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.cnt = self.cnt;
        copy.list = [self.list copyWithZone:zone];
    }
    
    return copy;
}


@end
