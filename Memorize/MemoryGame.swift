//
//  MemoryGame.swift
//  Memorize
//
//  Created by Simon Zhang on 3/19/23.
//

import Foundation

// Model class, handles data and logic
struct MemoryGame<CardContent> where CardContent: Equatable {
    // private set stands for only the setter is private, getter is public
    private(set) var cards: Array<Card>
    
    // indexOfTheOneAndOnlyFaceUpCard
    private var faceUpCardIndex: Int?
    
    // mutating stands for by calling this function, we will actually change the data of passed parameters
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = faceUpCardIndex {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                faceUpCardIndex = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                faceUpCardIndex = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
        }
        print("\(cards)")
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        //add numberOfPairsOfCards * 2 Cards to array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content,id: pairIndex * 2 + 1))
        }
    }
    
    // MemoryGame.Card
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
