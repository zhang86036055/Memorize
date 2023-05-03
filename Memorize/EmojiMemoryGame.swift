//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Simon Zhang on 3/19/23.
//

// ViewModel, part of ui. ViewModel is the gate keeper
// connection between view and model

import Foundation
import SwiftUI

// ObservableObject => observe object(data) change and publish to the world
class EmojiMemoryGame: ObservableObject {
    static let emojis = ["🐤", "🐧", "🪱", "🐙", "🐡", "🐠",
                         "🐅", "🦖", "🐬", "🦉", "🐔", "🐦",
                         "🦣", "🐆", "🦋", "🐣", "🐞", "🪰",
                         "🐵", "🐺", "🐌", "🐍", "🐉", "🐲"]

    // ViewModel is the gate keeper, protects the model
    static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 6) { index in
            emojis[index]
        }
    }
    // make model changes reactive to UI
    @Published private var model: MemoryGame<String> = createMemoryGame()

    // have a copy, so every time you are ask, you response your copy
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // Mark: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        // objectWillChange.send() == @Published on model
        model.choose(card)
    }


}
