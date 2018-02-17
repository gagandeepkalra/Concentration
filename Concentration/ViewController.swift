//
//  ViewController.swift
//  Concentration
//
//  Created by Gagandeep Kalra on 2/12/18.
//  Copyright © 2018 Gagandeep Kalra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
    
    var flipCount:Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func newGameCard(_ sender: UIButton) {
        flipCount = 0
        game.resetGame()
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            print("cardNumber = \(cardNumber)")
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                UIView.animate(withDuration: 1, animations: {
                    button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                })
            } else{
                button.setTitle("", for: UIControlState.normal)
                UIView.animate(withDuration: 1, animations: {
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                })
            }
        }
    }
    
    var emojiChoices: [String] = ["🎃", "👻", "👿", "👺"]
    
    var emoji = [Int: String]()
    
    func emoji(for card:Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
//    func flipCard(withEmoji emoji: String, on button: UIButton) {
//        if button.currentTitle == emoji {
//            resetCardButton(on: button)
//        } else {
//            button.setTitle(emoji, for: UIControlState.normal)
//            UIView.animate(withDuration: 2, animations: {
//                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
//            })
//        }
//    }
//
//    func resetCardButton(on button: UIButton) {
//        UIView.animate(withDuration: 2, animations: {
//            button.setTitle("", for: UIControlState.normal)
//            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
//        })
//        shuffleCards()
//    }
//
//
//    func setCardButton(on button: UIButton) {
//
//    }
    
    
}

