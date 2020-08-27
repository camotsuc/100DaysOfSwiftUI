# 100DaysOfSwiftUI

Here you can find solutions for every day in the challenge.

[Challenge 1](https://github.com/camotsuc/100DaysOfSwiftUI#challenge-1)

[Challenge 2](https://github.com/camotsuc/100DaysOfSwiftUI#challenge-2)

# Challenge 1

# 1
Add a header to the third section, saying “Amount per person”.
```swift
    Section(header: Text("Amount per person")) {
        Text("$\(eachAmount, specifier: "%.2f")")
    }
```
# 2
Add another section showing the total amount for the check – i.e., the original amount plus tip value, without dividing by the number of people.
```swift
Section(header: Text("Total amount")) {
    Text("$\(totalAmount, specifier: "%.2f")")
}
```
# 3
Change the “Number of people” picker to be a text field, making sure to use the correct keyboard type.
```swift
TextField("Peoples", text: $numberOfPeople)
    .keyboardType(.decimalPad)
}
```
First challenge was pretty easy, isn't it?

# Challenge 2

# 1 
Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert.
Firstly we need to add this variable.
```swift
 @State private var userScore = 0
```
After that we need to display an alert.
```swift
.alert(isPresented: $showingScore) {
    Alert(title: Text(scoreTitle), dismissButton: .default(Text("Countinue")) {
        self.askQuestion()
        })
    }
```
# 2
Show the player’s current score in a label directly below the flags
Add this code below the ForEach()
```swift
Text("Your score is \(userScore)")
    .foregroundColor(.white)
    .font(.largeTitle)
    .fontWeight(.black)
Spacer()
```
# 3
When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.
Firstly we need to create a variable, called tappedCounry .
```swift
@State private var tappedCountry = ""
```
And then use this in the our ForEach()
```swift
ForEach(0 ..< 3) { number in
    Button(action: {
        self.flagTapped(number)
            self.tappedCountry = self.countries[number] // Here we modify our tappedCounry variable
        }) {
            Image(self.countries[number])
                .renderingMode(.original)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.black))
                .shadow(color: .black, radius: 2)
        }
    }
```
After we'll change alert to show tappedCountry
```swift
.alert(isPresented: $showingScore) {
    Alert(title: Text(scoreTitle), message: Text("This is flag of \(tappedCountry)"), dismissButton: .default(Text("Countinue")) {
        self.askQuestion()
        })
}
```
