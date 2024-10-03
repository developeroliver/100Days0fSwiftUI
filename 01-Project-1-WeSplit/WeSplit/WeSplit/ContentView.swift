//
//  ContentView.swift
//  WeSplit
//
//  Created by olivier geiger on 03/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    private var finalTotal: Double {
        checkAmount + checkAmount * Double(tipPercentage) / 100
    }
    
    private var amountPerPerson: Double {
        finalTotal / Double(numberOfPeople)
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Montant")) {
                    TextField("Montant", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Fermer") {
                                    amountIsFocused = false
                                }
                            }
                        }
                }
                
                Section(header: Text("Nombre de personnes")) {
                    Picker("Nombre de personnes", selection: $numberOfPeople) {
                        ForEach(1...10, id:\.self) {
                            Text("\($0) pers")
                        }
                    }
                }
                
                Section(header: Text("Pourcentage de pourboire")) {
                    Picker("Pourcentage de pourboire", selection: $tipPercentage) {
                        ForEach(tipPercentages, id:\.self) {
                            Text("\($0) %")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Montant total après pourboire")) {
                    Text("$\(finalTotal, specifier: "%.2f")")
                }
                
                Section(header: Text("Montant par personne")) {
                    Text("$\(amountPerPerson, specifier: "%.2f")")
                }
            }
            .navigationTitle("We Split")
        }
    }
}

#Preview {
    ContentView()
}

