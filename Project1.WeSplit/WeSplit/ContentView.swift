//
//  ContentView.swift
//  WeSplit
//
//  Created by camotsuc on 15.07.2020.
//  Copyright © 2020 Robert Pliev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPecentage = 2
    @State private var tipPecentages = [10,15,20,25,0]
    
    var eachAmount: Double {
        let peopleCount = Double(numberOfPeople) ?? 1
        let tipSelection = Double(tipPecentages[tipPecentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tip = Double(tipPecentages[tipPecentage]) / 100
        let amount = Double(checkAmount) ?? 0
        let result = amount * tip
        
        return result + amount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount: ", text: $checkAmount)
                        .keyboardType(.decimalPad)

                    TextField("Peoples", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Tip %")) {
                    Picker("TipPercentage", selection: $tipPecentage) {
                        ForEach(0 ..< tipPecentages.count) {
                            Text("\(self.tipPecentages[$0]) %")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(eachAmount, specifier: "%.2f")")
                }
                Section(header: Text("Total amount")) {
                    Text("$\(totalAmount, specifier: "%.2f")")
                        .foregroundColor(tipPecentage == 4 ? Color.red : Color.black)
                }
            }
        .navigationBarTitle("WeSplit")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
