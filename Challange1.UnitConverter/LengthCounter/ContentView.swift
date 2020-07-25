//
//  ContentView.swift
//  LengthCounter
//
//  Created by camotsuc on 20.07.2020.
//  Copyright © 2020 Robert Pliev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var value = ""
    @State private var firstValueType = 0
    @State private var secondValueType = 0
    
    let chooseType = ["meters","kilometers","feets","yards","miles"]
    
    var calculateResult: String {
        let value = Double(self.value) ?? 0
        let firstValue: Measurement<UnitLength>
        var result: Measurement<UnitLength>
        switch chooseType[firstValueType] {
        case "meters":
            firstValue = Measurement(value: value, unit: UnitLength.meters)
        case "kilometers":
            firstValue = Measurement(value: value, unit: UnitLength.kilometers)
        case "feets":
            firstValue = Measurement(value: value, unit: UnitLength.feet)
        case "yards":
            firstValue = Measurement(value: value, unit: UnitLength.yards)
        case "miles":
            firstValue = Measurement(value: value, unit: UnitLength.miles)
        default:
            firstValue = Measurement(value: 0, unit: UnitLength.miles)
        }
        switch chooseType[secondValueType] {
        case "meters":
            result = firstValue.converted(to: .meters)
        case "kilometers":
            result = firstValue.converted(to: .kilometers)
        case "feets":
            result = firstValue.converted(to: .feet)
        case "yards":
            result = firstValue.converted(to: .yards)
        case "miles":
            result = firstValue.converted(to: .miles)
        default:
            result = firstValue.converted(to: .meters)
        }
        let stripped = String(result.description.dropLast(result.description.count - 5))
        return stripped
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter value here", text: $value)
                        .keyboardType(.decimalPad)
                
                }
                    Section(header: Text("Transfer this value")) {
                        Picker("Value", selection: $firstValueType) {
                            ForEach(0 ..< chooseType.count) {
                                Text("\(self.chooseType[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    Section(header: Text("To this value")) {
                        Picker("Value", selection: $secondValueType) {
                            ForEach(0 ..< chooseType.count) {
                                Text("\(self.chooseType[$0])")
                                    
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    Section(header: Text("Result is")) {
                        Text("\(calculateResult)")
                    }
                }
                .navigationBarTitle("LengthCounter")
            }
        }
    }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
