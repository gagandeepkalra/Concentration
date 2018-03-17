//
//  Card.swift
//  Concentration
//
//  Created by Gagandeep Kalra on 2/16/18.
//  Copyright © 2018 Gagandeep Kalra. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var hashValue: Int {
        return identifier
    }

    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    var isFaceUp = false
    var isMatched = false
    private var identifier:Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    static func reset() {
        identifierFactory = 0
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }

}
