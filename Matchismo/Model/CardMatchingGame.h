//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jesse Hu on 5/19/14.
//  Copyright (c) 2014 Jesse Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject
//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck;
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                        matchType:(NSUInteger)matchType;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)changeGameModeToMatchTwo;
- (void)changeGameModeToMatchThree;

@property (nonatomic, readonly) NSUInteger score;
@property (nonatomic, readonly) NSUInteger matchType;
@property (nonatomic, strong, readonly) NSString *lastResult;
@property (nonatomic, strong, readonly) NSMutableArray *resultsArray;

@end
