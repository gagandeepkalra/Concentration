//
//  Concentration.swift
//  Concentration
//
//  Created by Gagandeep Kalra on 2/16/18.
//  Copyright © 2018 Gagandeep Kalra. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for i in cards.indices {
                cards[i].isFaceUp = (i == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards:Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards): you must have atleast one pair of cards")
        
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
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards")
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[index] == cards[matchIndex] {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
            } else {
                // either no or 2 cards are face up, or touched the already faceUp card
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

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
