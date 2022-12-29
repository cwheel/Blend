//
//  mixes.swift
//  Blend
//
//  Created by Cameron Wheeler on 12/29/22.
//

import Foundation

let MinFillCost = 5.0

struct Mix: Hashable {
    var oxygen: Double
    var helium: Double
    var lpCost: Double?
    var cost: Double?
    var fixedCost: Bool?
    var name: String?
}

let Mixes = [
    Mix(oxygen: 21, helium: 0, lpCost: 6, cost: 8, fixedCost: true, name: "Air"),
    Mix(oxygen: 32, helium: 0, cost: 0.14, name: "Nitrox"),
    Mix(oxygen: 18, helium: 45, cost: 0.85),
    Mix(oxygen: 10, helium: 70, cost: 1.25),
    Mix(oxygen: 50, helium: 0, cost: 0.25, name: "50%"),
    Mix(oxygen: 30, helium: 30, cost: 0.56),
    Mix(oxygen: 100, helium: 0, cost: 0.35, name: "Oxygen"),
    Mix(oxygen: 0, helium: 100, cost: 1.75, name: "Helium")
]
