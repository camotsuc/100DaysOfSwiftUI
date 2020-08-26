//
//  Mission.swift
//  Project8.Moonshot
//
//  Created by camotsuc on 22.08.2020.
//  Copyright © 2020 robertpliev@gmail.com. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    var pilots: String {
        var crewNames = ""

        for member in crew {
            if let match = self.astronauts.first(where: { $0.id == member.name }) {
                crewNames += ("\(match.name), ")
            }
            else {
                fatalError("Crew member \(member.name) not found")
            }
        }
        return String(crewNames.dropLast(2))

    }
}

