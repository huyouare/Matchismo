//
//  ViewController.m
//  Matchismo
//
//  Created by Jesse Hu on 5/19/14.
//  Copyright (c) 2014 Jesse Hu. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    }
    return _game;
}
                 
- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)touchNewGameButton:(UIButton *)sender {
    self.segmentedControl.enabled = NO;
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    [self updateUI];
    self.segmentedControl.enabled = YES;
}

- (IBAction)changeMatchType:(UISegmentedControl *)sender {
    self.segmentedControl.enabled = NO;
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    if (sender.selectedSegmentIndex == 0) {
        [self.game changeGameModeToMatchTwo];
    } else {
        [self.game changeGameModeToMatchThree];
    }
    [self updateUI];
    self.segmentedControl.enabled = YES;
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	// Do any additional setup after loading the view, typically from a nib.
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
