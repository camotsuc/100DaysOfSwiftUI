//
//  ExpenseItem.swift
//  iExpense
//
//  Created by camotsuc on 18.08.2020.
//  Copyright © 2020 robertpliev@gmail.com. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
