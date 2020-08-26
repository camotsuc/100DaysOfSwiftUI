//
//  Bundle-Decodable.swift
//  Project8.Moonshot
//
//  Created by camotsuc on 22.08.2020.
//  Copyright © 2020 robertpliev@gmail.com. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Faled to locate the \(file)")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Faled to load the \(file)")
        }
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        return loaded
    }
}
