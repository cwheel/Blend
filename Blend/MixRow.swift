//
//  MixRow.swift
//  Blend
//
//  Created by Cameron Wheeler on 12/28/22.
//

import SwiftUI

struct MixRow: View {
    var currentOxygen: Double
    var currentHelium: Double
    var currentPressure: Double
    var tank: Tank

    var topupMix: Mix

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8).foregroundColor(Color("RowColor"))

            HStack {
                VStack {
                    HStack {
                        if let name = topupMix.name {
                            Text(name).fontWeight(.bold).foregroundColor(.blue)
                        } else {
                            Text("\(Int(topupMix.oxygen.rounded()))/\(Int(topupMix.helium.rounded()))").fontWeight(.bold).foregroundColor(.blue)
                        }

                        Spacer()
                    }

                    HStack {
                        Text("$\(finalMix.cost!.roundedPretty(.thousandths))")
                        Spacer()
                    }
                }

                Spacer()

                Text("\(Int(finalMix.oxygen.rounded()))/\(Int(finalMix.helium.rounded()))")
            }.padding()
        }
    }

    var finalMix: Mix {
        return calculateMix(
            currentHelium: currentHelium,
            currentOxygen: currentOxygen,
            currentPressure: currentPressure,
            tank: tank,
            topup: topupMix
        )
    }

    var rowColor: Color {
        if topupMix.helium > 0 {
            return Color(red: 0.7, green: 0.47, blue: 0)
        } else if topupMix.oxygen > 0 && topupMix.oxygen < 50 {
            return Color(red: 0.5, green: 0.6, blue: 0)
        } else {
            return Color(red: 0.8, green: 0.67, blue: 0)
        }
    }
}
