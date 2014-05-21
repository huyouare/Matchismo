//
//  PlayingCard.m
//  Matchismo
//
//  Created by Jesse Hu on 5/19/14.
//  Copyright (c) 2014 Jesse Hu. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank<=[PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    NSLog(@"%d", [otherCards count]);
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score += 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score += 1;
        }
    } else if ([otherCards count] == 2) {
        PlayingCard *firstCard = [otherCards firstObject];
        PlayingCard *secondCard = [otherCards objectAtIndex:1];
        //Match three
        if (firstCard.rank == self.rank && secondCard.rank == self.rank) {
            score += 12;
        } else if ([firstCard.suit isEqualToString:self.suit] && [secondCard.suit isEqualToString:self.suit]) {
            score += 5;
        }
        //Match first card
        else if (firstCard.rank == self.rank) {
            score += 4;
        } else if ([firstCard.suit isEqualToString:self.suit]) {
            score += 1;
        }
        //Match second card
        else if (secondCard.rank == self.rank) {
            score += 4;
        } else if ([secondCard.suit isEqualToString:self.suit]) {
            score += 1;
        }
        //Match other card together
        else if (secondCard.rank == firstCard.rank) {
            score += 4;
        } else if ([secondCard.suit isEqualToString:firstCard.suit]) {
            score += 1;
        }
    }
    
    return score;
}

@end
