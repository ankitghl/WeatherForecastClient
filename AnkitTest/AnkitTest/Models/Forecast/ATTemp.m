//
//  ATTemp.m
//
//  Created by Prateek Jain on 30/06/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ATTemp.h"


NSString *const kATTempNight = @"night";
NSString *const kATTempMin = @"min";
NSString *const kATTempEve = @"eve";
NSString *const kATTempDay = @"day";
NSString *const kATTempMax = @"max";
NSString *const kATTempMorn = @"morn";


@interface ATTemp ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ATTemp

@synthesize night = _night;
@synthesize min = _min;
@synthesize eve = _eve;
@synthesize day = _day;
@synthesize max = _max;
@synthesize morn = _morn;


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
            self.night = [[self objectOrNilForKey:kATTempNight fromDictionary:dict] doubleValue];
            self.min = [[self objectOrNilForKey:kATTempMin fromDictionary:dict] doubleValue];
            self.eve = [[self objectOrNilForKey:kATTempEve fromDictionary:dict] doubleValue];
            self.day = [[self objectOrNilForKey:kATTempDay fromDictionary:dict] doubleValue];
            self.max = [[self objectOrNilForKey:kATTempMax fromDictionary:dict] doubleValue];
            self.morn = [[self objectOrNilForKey:kATTempMorn fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.night] forKey:kATTempNight];
    [mutableDict setValue:[NSNumber numberWithDouble:self.min] forKey:kATTempMin];
    [mutableDict setValue:[NSNumber numberWithDouble:self.eve] forKey:kATTempEve];
    [mutableDict setValue:[NSNumber numberWithDouble:self.day] forKey:kATTempDay];
    [mutableDict setValue:[NSNumber numberWithDouble:self.max] forKey:kATTempMax];
    [mutableDict setValue:[NSNumber numberWithDouble:self.morn] forKey:kATTempMorn];

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

    self.night = [aDecoder decodeDoubleForKey:kATTempNight];
    self.min = [aDecoder decodeDoubleForKey:kATTempMin];
    self.eve = [aDecoder decodeDoubleForKey:kATTempEve];
    self.day = [aDecoder decodeDoubleForKey:kATTempDay];
    self.max = [aDecoder decodeDoubleForKey:kATTempMax];
    self.morn = [aDecoder decodeDoubleForKey:kATTempMorn];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_night forKey:kATTempNight];
    [aCoder encodeDouble:_min forKey:kATTempMin];
    [aCoder encodeDouble:_eve forKey:kATTempEve];
    [aCoder encodeDouble:_day forKey:kATTempDay];
    [aCoder encodeDouble:_max forKey:kATTempMax];
    [aCoder encodeDouble:_morn forKey:kATTempMorn];
}

- (id)copyWithZone:(NSZone *)zone
{
    ATTemp *copy = [[ATTemp alloc] init];
    
    if (copy) {

        copy.night = self.night;
        copy.min = self.min;
        copy.eve = self.eve;
        copy.day = self.day;
        copy.max = self.max;
        copy.morn = self.morn;
    }
    
    return copy;
}


@end
