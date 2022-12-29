//
//  mixer.swift
//  Blend
//
//  Created by Cameron Wheeler on 12/28/22.
//

import Foundation

func calculateMix(
    currentHelium: Double,
    currentOxygen: Double,
    currentPressure: Double,
    tank: Tank,
    topup: Mix
) -> Mix {
    let topupVolume = ((Double(tank.fillPressure) - currentPressure) / 100) * Double(tank.baseline)
    let topupOxygen = topupVolume * (topup.oxygen / 100)
    let topupHelium = topupVolume * (topup.helium / 100)

    let currentVolume = (currentPressure / 100) * Double(tank.baseline)
    let currentOxygen = currentVolume * (currentOxygen / 100)
    let currentHelium = currentVolume * (currentHelium / 100)

    let totalOxygen = topupOxygen + currentOxygen
    let totalHelium = topupHelium + currentHelium

    let totalVolume = (Double(tank.fillPressure) / 100) * Double(tank.baseline)
    let percentHelium = totalHelium / totalVolume
    let percentOxygen = totalOxygen / totalVolume

    let fixedCostFill = topup.fixedCost ?? false
    var cost = 0.0

    if fixedCostFill {
        if tank.fillPressure <= 3000 && topup.lpCost != nil {
            cost = topup.lpCost! * (tank.doubles ? 2 : 1)
        } else {
            cost = (topup.cost ?? 0) * (tank.doubles ? 2 : 1)
        }

    } else {
        cost = (topup.cost ?? 0) * topupVolume
    }

    cost = max(MinFillCost, cost)

    return Mix(
        oxygen: percentOxygen * 100,
        helium: percentHelium * 100,
        cost: cost
    )
}
