//
//  SetCard.h
//  Matchismo
//
//  Created by Jesse Hu on 5/27/14.
//  Copyright (c) 2014 Jesse Hu. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (nonatomic, strong) NSString *shape;
@property (nonatomic, strong) NSString *shading;
@property (nonatomic, strong) NSString *color;

+ (NSUInteger) maxNumber;
+ (NSArray *) validShapes;
+ (NSArray *) validShadings;
+ (NSArray *) validColors;

@end
