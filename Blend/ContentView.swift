//
//  ContentView.swift
//  Blend
//
//  Created by Cameron Wheeler on 12/28/22.
//

import SwiftUI

struct ContentView: View {
    @State private var currentPressure: String = ""
    @State private var currentHelium: String = ""
    @State private var currentOxygen: String = ""
    @State private var tank: Tank = Tanks[Tanks.count - 2]
    @State private var mixInvalid: Bool = false

    @FocusState private var initialFocus: Bool

    var body: some View {
        VStack {
            HStack {
                TextField("Current Pressure", text: $currentPressure, prompt: Text("2500"))
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .submitLabel(.done)
                    .focused($initialFocus)
                    .frame(width: 44)

                Text("PSI of").foregroundColor(.secondary)

                TextField("Current Oxygen", text: $currentOxygen, prompt: Text("O₂"))
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .submitLabel(.done)
                    .frame(width: 22)

                Text("/").foregroundColor(.secondary)

                TextField("Current Helium", text: $currentHelium, prompt: Text("He"))
                    .keyboardType(.decimalPad)
                    .submitLabel(.done)
                    .frame(width: 22)

                Text("in").foregroundColor(.secondary)

                Picker("Tank Size", selection: $tank) {
                    ForEach(Tanks, id: \.self) { tank in
                        Text(tank.name)

                    }
                }
                .scaledToFill()
                .padding(.leading, -10)
            }
            .padding(.top, invalidQuery ? 300 : 0)
            .animation(.default, value: invalidQuery)

            VStack {
                List {
                    ForEach(Mixes, id: \.self) { mix in
                        if !invalidQuery {
                            MixRow(
                                currentOxygen: Double(currentOxygen) ?? 0,
                                currentHelium: Double(currentHelium) ?? 0,
                                currentPressure: Double(currentPressure) ?? 0,
                                tank: tank,
                                topupMix: mix
                            )
                            .frame(height: 50)
                            .padding(.bottom, 10)
                            .listRowSeparator(.hidden)
                        }
                    }
                }
                .listStyle(.plain)
                .padding(.zero)
                .animation(.default, value: currentOxygen)
                .animation(.default, value: currentHelium)
                .animation(.default, value: currentPressure)
            }
        }
        .padding()
        .onAppear {
            initialFocus = true
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onChange(of: (currentOxygen.count == 2 || currentOxygen == "0") && currentHelium != "" ) { _ in
            if currentOxygen.count == 2 || currentOxygen == "0" {
                hideKeyboard()
            }

            mixInvalid = validateMix()
        }
        .onChange(of: currentHelium.count == 2 || currentHelium == "0") { _ in
            hideKeyboard()
            mixInvalid = validateMix()
        }
        .alert(isPresented: $mixInvalid) {
            Alert(
                title: Text("Invalid Mix"),
                message: Text("O₂ and He must add to 100 or less"),
                dismissButton: Alert.Button.default(
                    Text("Ok"), action: {
                        currentOxygen = ""
                        currentHelium = ""
                    }
                )
            )
        }
    }

    var invalidQuery: Bool {
        return currentOxygen == "" || currentHelium == "" || currentPressure == ""
    }

    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }

    func validateMix() -> Bool {
        return (Double(currentOxygen) ?? 0) + (Double(currentOxygen) ?? 0) > 100
    }
}
