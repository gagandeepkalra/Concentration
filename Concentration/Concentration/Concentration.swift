//
//  Concentration.swift
//  Concentration
//
//  Created by Gagandeep Kalra on 2/16/18.
//  Copyright © 2018 Gagandeep Kalra. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    init(numberOfPairsOfCards:Int) {
        addCards(numberOfPairsOfCards)
        shuffleCards()
    }
    
    func addCards(_ count: Int) {
        for _ in 1...count {
            let card = Card()
            cards += [card, card]
        }
    }
    
    func shuffleCards() {
        for i in 0..<cards.count {
            cards.swapAt(i, Int(arc4random_uniform(UInt32(cards.count))))
        }
    }
    
    func chooseCard(at index:Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[index].identifier == cards[matchIndex].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no or 2 cards are face up
                for i in cards.indices {
                    cards[i].isFaceUp = false
                }
                indexOfOneAndOnlyFaceUpCard = index
            }
            cards[index].isFaceUp = true
        }
    }
    
    func resetGame() {
        indexOfOneAndOnlyFaceUpCard = nil
        Card.reset()
        
        let numberOfPairsOfCards:Int = cards.count / 2
        cards.removeAll()
        
        addCards(numberOfPairsOfCards)
        shuffleCards()
    }
}
