import Foundation

public class Cards {
    
    public init() {}
    
    var cardDeck: [String: Int] = [:]
    var foundFirstDeckFilled = false
    
    public func countCards(n :Int) {
        
        var i = 0
        
        while i < n {
            
            let num = Int.random(in: 1...32)
            
            print("#\(i): \(num)")
            if cardDeck.keys.contains("\(num)") {
                cardDeck["\(num)"]? += 1
            } else {
                cardDeck["\(num)"] = 1
            }
            
           i += 1
        
            if(cardDeck.count == 32 && cardDeck.allSatisfy{$0.value >= 1} && !foundFirstDeckFilled){
                print("Deck is filled after the \(i). card")
                foundFirstDeckFilled = !foundFirstDeckFilled
            }
            
        }
        
        let numDecks = cardDeck.min{ a, b in a.value < b.value}
        
        print("Number of completed decks is \(numDecks?.value).")
    }
}
