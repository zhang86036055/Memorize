//
//  ContentView.swift
//  Memorize
//
//  Created by Simon Zhang on 3/18/23.
//

import SwiftUI

struct ContentView: View {
    // Rebuild UI when observedObject is changed
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            ScrollView {
                // adaptive provides a minimum width for each card
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
        }
        .foregroundColor(.red)
        .padding()
    }
}
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape  = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
                    .padding()
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}



/*
// Will not use this button according to professor's requests
struct ButtonView: View {
    @Binding var emojiCount: Int
    var emojisCount: Int
    var body: some View {
        HStack {
            Button(
                action: { if emojiCount < emojisCount { emojiCount += 1 } },
                label: {
                    Image(systemName: "plus.circle")
                }
            )
            Spacer()
            Button(
                action: { if emojiCount > 0 { emojiCount -= 1 }},
                label: {
                    Image(systemName: "minus.circle")
                }
            )
        }
        .font(.largeTitle)
        .padding(.horizontal)
    }
}
*/








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
            .previewDevice("iPhone 14 pro")
            .preferredColorScheme(.dark)
    }
}
