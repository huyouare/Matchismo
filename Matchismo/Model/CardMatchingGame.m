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
@property (nonatomic, strong, readwrite) NSString *lastResult;
@property (nonatomic, strong, readwrite) NSMutableArray *resultsArray;

@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

@synthesize lastResult = _lastResult;

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

- (NSArray *)resultsArray
{
    if (!_resultsArray) {
        _resultsArray = [[NSMutableArray alloc] init];
    }
    return _resultsArray;
}

- (NSString *)lastResult
{
    if (!_lastResult) {
        _lastResult = [NSString stringWithFormat:@""];
    }
    return _lastResult;
}

- (void)setLastResult:(NSString *)lastResult
{
    _lastResult = lastResult;
    [self.resultsArray addObject:lastResult];
    if ([self.resultsArray count] > 10) {
        [self.resultsArray removeObjectAtIndex:0];
    }
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
    //TWO-CARD MATCH
    if (self.matchType == 2) {
        Card *card = [self cardAtIndex:index];
        if (!card.isMatched) {
            
            if (card.isChosen) {
                card.chosen = NO;
                self.lastResult = @"";
            } else {
                BOOL wasMatched = NO;
                //match against other cards
                for (Card * otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            card.matched = YES;
                            otherCard.matched = YES;
                            self.lastResult = [NSString stringWithFormat:@"Matched %@ and %@ for %d points.", card.contents, otherCard.contents, (matchScore * MATCH_BONUS)];
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            card.chosen = NO;
                            otherCard.chosen = NO;
                            self.lastResult = [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty.", card.contents, otherCard.contents, (MISMATCH_PENALTY)];
                        }
                        wasMatched = YES;
                        break; //only 2 for now
                    }
                }
                
                if (!wasMatched) {
                    self.lastResult = [NSString stringWithFormat:@"%@ selected.", card.contents];
                }
                
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            }
        }
    }
    //THREE-CARD MATCH
    else if (self.matchType == 3) {
        Card *card = [self cardAtIndex:index];
        if (!card.isMatched) {
            
            if (card.isChosen) {
                card.chosen = NO;
                //TODO: Find out which card is still chosen
                self.lastResult = @"";
            } else {
                //match against other cards
                NSMutableArray *cardArray = [[NSMutableArray alloc] init];
                for (Card * otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        [cardArray addObject:otherCard];
                    }
                }
                
                if ([cardArray count] == 2) {
                    //Three cards selected
                    int matchScore = [card match:cardArray];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        Card *firstCard = [cardArray objectAtIndex:0];
                        Card *secondCard = [cardArray objectAtIndex:1];
                        firstCard.matched = YES;
                        secondCard.matched = YES;
                        self.lastResult = [NSString stringWithFormat:@"Matched %@, %@ and %@ for %d points.", card.contents, firstCard.contents, secondCard.contents, (matchScore * MATCH_BONUS)];
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        Card *firstCard = [cardArray objectAtIndex:0];
                        Card *secondCard = [cardArray objectAtIndex:1];
                        card.chosen = NO;
                        firstCard.chosen = NO;
                        secondCard.chosen = NO;
                        self.lastResult = [NSString stringWithFormat:@"%@, %@ and %@ don't match! %d point penalty.", card.contents, firstCard.contents, secondCard.contents, (MISMATCH_PENALTY)];
                    }
                } else if ([cardArray count] == 1) {
                    //Two cards currently selected
                    Card *otherCard = [cardArray objectAtIndex:0];
                    self.lastResult = [NSString stringWithFormat:@"%@ and %@ selected.", card.contents, otherCard.contents];
                } else {
                    //One card selected
                    self.lastResult = [NSString stringWithFormat:@"%@ selected.", card.contents];
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
