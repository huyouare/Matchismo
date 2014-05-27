//
//  SetCard.m
//  Matchismo
//
//  Created by Jesse Hu on 5/27/14.
//  Copyright (c) 2014 Jesse Hu. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize shape = _shape;
@synthesize shading = _shading;
@synthesize color = _color;

+ (NSArray *) numberStrings
{
    return @[@"?", @"1", @"2", @"3"];
}

+ (NSUInteger) maxNumber
{
    return [[SetCard numberStrings] count] - 1;
}

+ (NSArray *) validShapes
{
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *) validShadings
{
    return @[@"solid", @"open", @"striped"];
}

+ (NSArray *) validColors
{
    return @[@"red", @"green", @"purple"];
}

- (NSString *)contents
{
    NSArray *numberStrings = [SetCard numberStrings];
    return [NSString stringWithFormat:@"%@ %@ %@ %@", numberStrings[self.number], self.color, self.shading, self.shape];
}

- (void)setNumber:(NSUInteger)number
{
    if (number <= [SetCard maxNumber]) {
        _number = number;
    }
}

- (NSString *)shape
{
    return _shape ? _shape : @"?";
}

- (void)setShape:(NSString *)shape
{
    if ([[SetCard validShapes] containsObject:shape]) {
        _shape = shape;
    }
}

- (NSString *)shading
{
    return _shading ? _shading : @"?";
}

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (NSString *)color
{
    return _color ? _color : @"?";
}

- (void)setColor:(NSString *)color
{
    if ([[SetCard validShadings] containsObject:color]) {
        _color = color;
    }
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if ([otherCards count] == 2) {
        SetCard *firstCard = [otherCards firstObject];
        SetCard *secondCard = [otherCards objectAtIndex:1];
        
        
        
//        //Match three
//        if (firstCard.rank == self.rank && secondCard.rank == self.rank) {
//            score += 12;
//        } else if ([firstCard.suit isEqualToString:self.suit] && [secondCard.suit isEqualToString:self.suit]) {
//            score += 5;
//        }

    }
}

@end
