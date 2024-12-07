//
//  SpeedView.swift
//  UnityTune
//
//  Created by Fabian Leśniak on 31/07/2023.
//

import SwiftUI

struct SpeedView: View {
    @State private var unitSpeedValue = 0.0
    @State private var unitSpeedResult = 0.0
    @State private var selectSpeedUnit = "kmph"
    @State private var speedUnits = ["kmph", "mph"]
    
    @FocusState private var valueIsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Value", value: $unitSpeedValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocused)
                    
                    Picker("Choose speed unit", selection: $selectSpeedUnit) {
                        ForEach(speedUnits, id: \.self){ unit in
                            Text(unit).tag(unit)
                        }
                    }
                } header: {
                    Text("Enter the speed in \(selectSpeedUnit)")
                }
                
                Section {
                    Text("\(Int(unitSpeedResult))")
                    
                    Button("Convert") {
                        if selectSpeedUnit == "kmph" {
                            kphToMph(unitSpeedValue)
                        } else {
                            mphToKph(unitSpeedValue)
                        }
                    }
                    
                } header: {
                    Text("Converted speed in \(selectSpeedUnit == "kmph" ? "mph" : "kmph")")
                }
            }
            .navigationTitle("UnityTune")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        valueIsFocused = false
                    }
                }
            }
        }
    }
    
    func kphToMph(_ kph: Double) {
        unitSpeedResult = kph * 0.621371
    }

    func mphToKph(_ mph: Double) {
        unitSpeedResult = mph / 0.621371
    }
}


struct SpeedView_Previews: PreviewProvider {
    static var previews: some View {
        SpeedView()
    }
}
