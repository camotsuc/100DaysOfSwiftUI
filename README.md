# 100DaysOfSwiftUI

Here you can find solutions for every day in the challenge.

[Challenge 1](https://github.com/camotsuc/100DaysOfSwiftUI#challenge-1)

# Challenge 1

# 2
We can shuffle cards in our init of our Model **MemoryGame**.
```swift
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle() //Here we can shuffle the cards
    }
```
In swift we have a built-in method called **shuffle()**, and he is shuffling elements.
