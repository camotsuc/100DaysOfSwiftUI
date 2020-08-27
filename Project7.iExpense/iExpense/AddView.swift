//
//  AddView.swift
//  iExpense
//
//  Created by camotsuc on 18.08.2020.
//  Copyright © 2020 robertpliev@gmail.com. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var wrong = false
    static let types = ["Bussines","Personal"]
    var body: some View {
        NavigationView {
            Form() {
                Section(header: Text("Set the name of the product")) {
                    TextField("Name", text: $name)
                }
                Section(header: Text("Set the type of the product")) {
                    Picker("Type", selection: $type) {
                        ForEach(Self.types, id: \.self) {
                            Text($0)
                        }
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Set price of the product")) {
                    TextField("Price", text: $amount)
                        .keyboardType(.numberPad)
                }
            }
            .navigationBarTitle("Add new item")
            .navigationBarItems(trailing: Button("Save") {
                if Int(self.amount) == nil {
                    self.wrong = true
                }
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
                .alert(isPresented: $wrong) {
                    Alert( title: Text("You can't use words as price"), dismissButton: .default(Text("Got it!")))
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
