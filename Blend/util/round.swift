//
//  round.swift
//  Blend
//
//  Created by Cameron Wheeler on 12/28/22.
//

import Foundation

public enum DoubleNearestRoundingRule {
    case hundredths
    case thousandths
}

public extension Double {
    func roundedPretty(_ rule: DoubleNearestRoundingRule) -> String {
        let hundredthsRound = Foundation.round(self * 100) / 100.0

        if rule == .hundredths {
            if hundredthsRound == Foundation.round(self) {
                return String(format: "%.0f", arguments: [Foundation.round(self)])
            }

            return String(format: "%.1f", arguments: [hundredthsRound])
        } else if rule == .thousandths {
            let thousandthsRound = Foundation.round(self * 1000) / 1000.0

            if thousandthsRound == hundredthsRound {
                if hundredthsRound == Foundation.round(self) {
                    return String(format: "%.0f", arguments: [Foundation.round(self)])
                }

                return String(format: "%.1f", arguments: [hundredthsRound])
            }

            return String(format: "%.2f", arguments: [thousandthsRound])
        }

        return String(format: "%.0f", arguments: [self])
    }
}
