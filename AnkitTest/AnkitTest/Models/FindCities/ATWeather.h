//
//  ATWeather.h
//
//  Created by Ankit Gohel on 29/06/16
//  Copyright (c) 2016 Netwin Infosolutions. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ATWeather : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double weatherIdentifier;
@property (nonatomic, strong) NSString *main;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *weatherDescription;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
