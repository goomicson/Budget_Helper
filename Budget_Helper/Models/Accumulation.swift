//
//  Accumulation.swift
//  Swiftbook_BudgetHelperProject
//
//  Created by Shevshelev Lev on 15.11.2021.
//

import Foundation

struct Accumulation {
    let name: String
    let totalAmount: Double
    let dayOfProfit: Int

    var currentAmount: Double = 0
    var duration: Int
    
    var exchange: Exchange
    
    var percent: Double {
        round(currentAmount / totalAmount * 100)
    }
    var monthlyPayment: Double {
        totalAmount / Double(duration)
    }
}

extension Accumulation {
    enum Exchange {
        case dollar
        case euro
        case ruble
    }
}

extension Accumulation {
    static func getData() -> [Accumulation] {
        let accumulations = [Accumulation(name: "First Accumulation", totalAmount: 100000, dayOfProfit: 12, currentAmount: 50, duration: 12, exchange: .ruble),
                             Accumulation(name: "Second Accumulation", totalAmount: 18000, dayOfProfit: 14, duration: 15, exchange: .dollar),
                             Accumulation(name: "Third", totalAmount: 1000000, dayOfProfit: 26, currentAmount: 2, duration: 120, exchange: .euro)]
        return accumulations
    }
}
