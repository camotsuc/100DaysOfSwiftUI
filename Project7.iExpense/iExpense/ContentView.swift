//
//  ContentView.swift
//  iExpense
//
//  Created by camotsuc on 18.08.2020.
//  Copyright © 2020 robertpliev@gmail.com. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text("$\(item.amount)")
                            .foregroundColor(self.getColor(amount: item.amount))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingAddExpense = true
            }) {
                Image(systemName: "plus")
            })
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: self.expenses)
            }
        }
    }
    func removeItems(at offSets: IndexSet) {
        expenses.items.remove(atOffsets: offSets)
    }
    func getColor(amount: Int) -> Color? {
        if amount <= 10 {
            return Color.gray
        } else if amount >= 11 && amount <= 100 {
            return Color.purple
        } else {
            return Color.red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
