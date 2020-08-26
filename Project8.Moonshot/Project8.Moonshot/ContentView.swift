//
//  ContentView.swift
//  Project8.Moonshot
//
//  Created by camotsuc on 21.08.2020.
//  Copyright © 2020 robertpliev@gmail.com. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showNames = false
    var body: some View {
        NavigationView {
                List(self.missions) { mission in
                    NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                        
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                                .padding(1)
                            Text(self.showNames ? mission.pilots : mission.formattedLaunchDate)
                                .font(.system(size: 16))
                            
                                .lineLimit(2)
                        }
                    }
                }
                .navigationBarTitle("Moonshot")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.showNames.toggle()
                    }) {
                        Text(self.showNames ? "Show launch dates" : "Show pilots names")
                })
                    .animation(.easeIn)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
