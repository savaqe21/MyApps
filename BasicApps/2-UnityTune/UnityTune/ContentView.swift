//
//  ContentView.swift
//  UnityTune
//
//  Created by Fabian Leśniak on 31/07/2023.
//

import SwiftUI

struct ContentView: View {    
    var body: some View {
        NavigationView{
            List {
                Section(header: Text("Temperature converter")) {
                    NavigationLink("Temperature", destination: TemperatureView())
                }
                
                Section(header: Text("Speed converter")) {
                    NavigationLink("Speed", destination: SpeedView())
                }
            }
            .navigationTitle("UnityTune")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
