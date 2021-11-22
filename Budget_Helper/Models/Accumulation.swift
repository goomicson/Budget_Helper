//
//  Accumulation.swift
//  Swiftbook_BudgetHelperProject
//
//  Created by Shevshelev Lev on 15.11.2021.
//

import Foundation

struct Accumulation {
    let name: String
    let totalAmount: Int
    let dayOfProfit: Date
    
    var duration: Int
    var exchange: Exchange
    var currentAmount: Double = 0
    
    var percent: Float {
        Float((currentAmount / Double(totalAmount) * 100) / 100)
        
    }
    var monthlyPayment: Int {
        totalAmount / duration
    }
}

//MARK: - GetData

extension Accumulation {
    static func getData() -> [Accumulation] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yy"
        let dateString = ["09.09.21", "09.12.21", "09.01.22"]
        
        var dates: [Date] = []
        
        for date in dateString {
            if let formattedDate = dateFormatter.date(from: date) {
                dates.append(formattedDate)
            }
        }
        let accumulations = [Accumulation(name: "Audi Q7", totalAmount: 100000, dayOfProfit: dates[0], duration: 24, exchange: .dollar, currentAmount: 73500),
                             Accumulation(name: "Macbook Pro 14", totalAmount: 5000, dayOfProfit: dates[1], duration: 18, exchange: .dollar),
                             Accumulation(name: "Trip to Australia", totalAmount: 12000, dayOfProfit: dates[2], duration: 120, exchange: .dollar, currentAmount: 5750)]
        return accumulations
    }
}
