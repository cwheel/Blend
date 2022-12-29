//
//  tanks.swift
//  Blend
//
//  Created by Cameron Wheeler on 12/29/22.
//

import Foundation

struct Tank: Hashable {
    var name: String
    var baseline: Double
    var fillPressure: Int
    var doubles: Bool
}

let Tanks = [
    Tank(name: "AL13", baseline: 0.43, fillPressure: 3000, doubles: false),
    Tank(name: "AL40", baseline: 1.3, fillPressure: 3000, doubles: false),
    Tank(name: "AL80", baseline: 2.7, fillPressure: 3000, doubles: false),
    Tank(name: "LP50's", baseline: 3.7, fillPressure: 3600, doubles: true),
    Tank(name: "LP85's", baseline: 6.4, fillPressure: 3600, doubles: true),
    Tank(name: "LP108's", baseline: 8.1, fillPressure: 3600, doubles: true),
    Tank(name: "HP100's", baseline: 5.8, fillPressure: 3400, doubles: true)
]
