//
//  ViewController.h
//  Matchismo
//
//  Created by Jesse Hu on 5/19/14.
//  Copyright (c) 2014 Jesse Hu. All rights reserved.
//
// Abstract class. Must implement methods as described.

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

// protected
// for subclasses
- (Deck *)createDeck; // Abstract method

@end
