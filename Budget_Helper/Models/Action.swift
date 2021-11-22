//
//  Action.swift
//  Swiftbook_BudgetHelperProject
//
//  Created by Shevshelev Lev on 15.11.2021.
//

import Foundation

struct Action {
    let amount: Double
    let direction: Bool // True - profit, False - less
    let startDate: Date
    let frequency: Frequency
    let exchange: Exchange
    
    var name: String = ""
    var endDate: Date? = nil
}

extension Action {
    enum Frequency {
        case none
        case week
        case month
        case year
    }
}

//MARK: - Comparable

extension Action: Comparable {
    static func < (lhs: Action, rhs: Action) -> Bool {
        lhs.startDate < rhs.startDate
    }
}

//MARK: - GetRepeatAction
// This function returns an array of repeating actions

extension Action {
    
     static func getRepeatAction(_ event: Action) -> [Action] {
         let calendar = Calendar.current
         var repeatEvents: [Action] = []
         let week: TimeInterval = 60 * 60 * 24 * 7
         let longMonth: TimeInterval = 60 * 60 * 24 * 31
         let shortMonth: TimeInterval = 60 * 60 * 24 * 30
         let February: TimeInterval = 60 * 60 * 24 * 28
         let leapFebruary: TimeInterval = 60 * 60 * 24 * 29
         let year: TimeInterval = 60 * 60 * 24 * 365
         let leapYear: TimeInterval = 60 * 60 * 24 * 366
         let endDate: Date = event.endDate ?? Date.init(timeInterval: year * 80, since: event.startDate)
         
         
         switch event.frequency {
             
         case .none:
             repeatEvents.append(event)
             return repeatEvents
         case .week:
             repeatEvents.append(event)
             var newEvent = event
             while newEvent.startDate < endDate {
                 newEvent = Action(amount: event.amount,
                                       direction: event.direction,
                                       startDate: Date.init(timeInterval: week, since: repeatEvents.last!.startDate),
                                       frequency: event.frequency,
                                       exchange: event.exchange,
                                       endDate: endDate)
                 if newEvent.startDate > endDate {break}
                     repeatEvents.append(newEvent)
             }
         case .month:
             repeatEvents.append(event)
             var newEvent = event
             while newEvent.startDate < endDate {
                 let eventMonth = calendar.component(.month, from: newEvent.startDate)
                 switch eventMonth {
                 case 1, 3, 5, 7, 8, 10, 12:
                     newEvent = Action(amount: event.amount,
                                       direction: event.direction,
                                       startDate: Date.init(timeInterval: longMonth, since: repeatEvents.last!.startDate),
                                       frequency: event.frequency,
                                       exchange: event.exchange,
                                       endDate: endDate)
                case 4, 6, 9, 11:
                     newEvent = Action(amount: event.amount,
                                       direction: event.direction,
                                       startDate: Date.init(timeInterval: shortMonth, since: repeatEvents.last!.startDate),
                                       frequency: event.frequency,
                                       exchange: event.exchange,
                                       endDate: endDate)
                default:
                    let eventYear = calendar.component(.year, from: newEvent.startDate)
                    if eventYear % 4 == 0 {
                        newEvent = Action(amount: event.amount,
                                          direction: event.direction,
                                          startDate: Date.init(timeInterval: leapFebruary, since: repeatEvents.last!.startDate),
                                          frequency: event.frequency,
                                          exchange: event.exchange,
                                          endDate: endDate)
                    } else {
                        newEvent = Action(amount: event.amount,
                                          direction: event.direction,
                                          startDate: Date.init(timeInterval: February, since: repeatEvents.last!.startDate),
                                          frequency: event.frequency,
                                          exchange: event.exchange,
                                          endDate: endDate)
                    }
                 }
                 if newEvent.startDate > endDate {break}
                 repeatEvents.append(newEvent)
             }
        case .year:
            repeatEvents.append(event)
             var newEvent = event
            while newEvent.startDate < endDate {
                let eventYear = calendar.component(.year, from: repeatEvents.last!.startDate)
                if eventYear % 4 == 0 {
                    newEvent = Action(amount: event.amount,
                                          direction: event.direction,
                                          startDate: Date.init(timeInterval: leapYear, since: repeatEvents.last!.startDate),
                                          frequency: event.frequency,
                                          exchange: event.exchange,
                                          endDate: endDate)
                    if newEvent.startDate > endDate {break}
                    repeatEvents.append(newEvent)
                } else {
                    newEvent = Action(amount: event.amount,
                                          direction: event.direction,
                                          startDate: Date.init(timeInterval: year, since: repeatEvents.last!.startDate),
                                          frequency: event.frequency,
                                          exchange: event.exchange,
                                          endDate: endDate)
                    if newEvent.startDate > endDate {break}
                    repeatEvents.append(newEvent)
                }
            }
        }
         return repeatEvents
     }
}

//MARK: - GetData

extension Action {
    static func getData() -> [Action] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yy"
        let dateString = ["09.09.21", "09.12.21", "09.01.22", "09.12.26", "29.11.21", "01.12.24", "30.11.21", "18.11.22"]
        
        var dates: [Date] = []
        
        for date in dateString {
            if let formattedDate = dateFormatter.date(from: date) {
                dates.append(formattedDate)
            }
        }
        let actions = [
            Action(amount: 10000, direction: true, startDate: dates[0], frequency: .week, exchange: .euro, name: "", endDate: dates[1]),
            Action(amount: 4500, direction: false, startDate: dates[2], frequency: .year, exchange: .dollar, name: "Netflix Subscription", endDate: dates[3]),
            Action(amount: 1453839, direction: true, startDate: dates[4], frequency: .month, exchange: .ruble, name: "", endDate: dates[5]),
            Action(amount: 5000, direction: false, startDate: dates[6], frequency: .month, exchange: .euro, name: "Parking", endDate: dates[7]),
            Action(amount: 236793, direction: true, startDate: Date(), frequency: .none, exchange: .dollar),
            Action(amount: 169, direction: false, startDate: Date(), frequency: .month, exchange: .ruble, name: "Apple Music")
        ]
        return actions
    }
}
