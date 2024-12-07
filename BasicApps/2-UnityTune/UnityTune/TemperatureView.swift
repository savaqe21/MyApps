//
//  TemperatureView.swift
//  UnityTune
//
//  Created by Fabian Leśniak on 31/07/2023.
//

import SwiftUI

struct TemperatureView: View {
    @State private var unitTemperatureValue = 0.0
    @State private var unitTemperatureResult = 0.0
    @State private var selectTemperatureUnit = "°C"
    @State private var temperatureUnits = ["°C", "°F"]
    
    @FocusState private var valueIsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Value", value: $unitTemperatureValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocused)
                    
                    Picker("Choose temperature unit", selection: $selectTemperatureUnit) {
                        ForEach(temperatureUnits, id: \.self){ unit in
                            Text(unit).tag(unit)
                        }
                    }
                } header: {
                    Text("Enter the temperature in \(selectTemperatureUnit)")
                }
                
                Section {
                    Text("\(Int(unitTemperatureResult))")
                    
                    Button("Convert") {
                        if selectTemperatureUnit == "°C" {
                            celsiusToFahrenheit(unitTemperatureValue)
                        } else {
                            fahrenheitToCelsius(unitTemperatureValue)
                        }
                    }
                } header: {
                    Text("Converted temperature in \(selectTemperatureUnit == "°C" ? "°F" : "°C")")
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
    
    func celsiusToFahrenheit(_ celsius: Double) {
        unitTemperatureResult = (celsius * 9/5) + 32
    }

    func fahrenheitToCelsius(_ fahrenheit: Double) {
        unitTemperatureResult = (fahrenheit - 32) * 5/9
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView()
    }
}
