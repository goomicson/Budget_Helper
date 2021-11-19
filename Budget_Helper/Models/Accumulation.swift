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
    let dayOfProfit: Date

    var currentAmount: Double = 0
    var duration: Int
    
    var exchange: Exchange
    
    var percent: Float {
        Float(round(currentAmount / totalAmount * 100) / 100)
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let datesString = ["22.11.2021", "23.12.2021", "25.08.1998"]
        var dates: [Date] = []
        for datesString in datesString {
            if let date = dateFormatter.date(from: datesString) {
                dates.append(date)
            }
        }
        let accumulations = [Accumulation(name: "First Accumulation", totalAmount: 100000, dayOfProfit: dates[0], currentAmount: 50, duration: 12, exchange: .ruble),
                             Accumulation(name: "Second Accumulation", totalAmount: 18000, dayOfProfit: dates[1], duration: 15, exchange: .dollar),
                             Accumulation(name: "Third", totalAmount: 1000000, dayOfProfit: dates[2], currentAmount: 2, duration: 120, exchange: .euro)]
        return accumulations
    }
}
