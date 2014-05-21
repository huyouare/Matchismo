//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jesse Hu on 5/19/14.
//  Copyright (c) 2014 Jesse Hu. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSUInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card
@property (nonatomic, readwrite) NSUInteger matchType;

@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    if (self)
    {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}


- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                        matchType:(NSUInteger)matchType
{
    self = [self initWithCardCount:count usingDeck:deck];
    self.matchType = matchType;
    return self;
}

- (NSString *)lastResult
{
    if (!_lastResult) {
        _lastResult = [NSString stringWithFormat:@""];
    }
    return _lastResult;
}

- (void)changeGameModeToMatchTwo
{
    self.matchType = 2;
    
}

- (void)changeGameModeToMatchThree
{
    self.matchType = 3;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    if (self.matchType == 2) {
        Card *card = [self cardAtIndex:index];
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
            } else {
                //match against other cards
                for (Card * otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            card.matched = YES;
                            otherCard.matched = YES;
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                            
                        }
                        break; //only 2 for now
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            }
        }
    }
    else if (self.matchType == 3) {
        Card *card = [self cardAtIndex:index];
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
            } else {
                //match against other cards
                NSMutableArray *cardArray = [[NSMutableArray alloc] init];
                for (Card * otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        [cardArray addObject:otherCard];
                    }
                }
                if ([cardArray count] == 2) {
                    int matchScore = [card match:cardArray];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        for (Card *c in cardArray) {
                            c.matched = YES;
                        }
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        for (Card *c in cardArray) {
                            c.chosen = NO;
                        }
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            }
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
