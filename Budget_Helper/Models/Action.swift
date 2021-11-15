//
//  Action.swift
//  Swiftbook_BudgetHelperProject
//
//  Created by Shevshelev Lev on 15.11.2021.
//

import Foundation

struct Action {
    let name: String
    let amount: Double
    let direction: Bool // True - profit, False - less
    let startDate: Date
    let frequency: Frequency
    
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

extension Action {
    
     static func getRepeatAction(_ event: Action) -> [Action] {
         let calendar = Calendar.current
         var repeatEvents: [Action] = []
         let endDate: Date = event.endDate ?? Date.init(timeInterval: 60 * 60 * 24 * 365 * 80, since: event.startDate)
         let week: TimeInterval = 60 * 60 * 24 * 7
         let longMonth: TimeInterval = 60 * 60 * 24 * 31
         let shortMonth: TimeInterval = 60 * 60 * 24 * 30
         let February: TimeInterval = 60 * 60 * 24 * 28
         let leapFebruary: TimeInterval = 60 * 60 * 24 * 29
         let year: TimeInterval = 60 * 60 * 24 * 365
         let leapYear: TimeInterval = 60 * 60 * 24 * 366
         
         
         switch event.frequency {
             
         case .none:
             return repeatEvents
         case .week:
             repeatEvents.append(event)
             while repeatEvents.last!.startDate < endDate {
                 let newEvent = Action(name: event.name, amount: event.amount,
                                        direction: event.direction,
                                        startDate: Date.init(timeInterval: week , since: repeatEvents.last!.startDate),
                                        frequency: event.frequency,
                                        endDate: endDate)
                 if newEvent.startDate > endDate {break}
                     repeatEvents.append(newEvent)
             }
         case .month:
             repeatEvents.append(event)
             while repeatEvents.last!.startDate < endDate {
                 var newEvent = event
                 let eventMonth = calendar.component(.month, from: repeatEvents.last!.startDate)
                 switch eventMonth {
                 case 1, 3, 5, 7, 8, 10, 12:
                    newEvent = Action(name: event.name, amount: event.amount,
                                           direction: event.direction,
                                           startDate: Date.init(timeInterval: longMonth , since: repeatEvents.last!.startDate),
                                           frequency: event.frequency,
                                           endDate: endDate)
                case 4, 6, 9, 11:
                    newEvent = Action(name: event.name, amount: event.amount,
                                           direction: event.direction,
                                           startDate: Date.init(timeInterval: shortMonth , since: repeatEvents.last!.startDate),
                                           frequency: event.frequency,
                                           endDate: endDate)
                default:
                    let eventYear = calendar.component(.year, from: repeatEvents.last!.startDate)
                    if eventYear % 4 == 0 {
                        newEvent = Action(name: event.name, amount: event.amount,
                                               direction: event.direction,
                                               startDate: Date.init(timeInterval: leapFebruary , since: repeatEvents.last!.startDate),
                                               frequency: event.frequency,
                                               endDate: endDate)
                    } else {
                        newEvent = Action(name: event.name, amount: event.amount,
                                           direction: event.direction,
                                           startDate: Date.init(timeInterval: February , since: repeatEvents.last!.startDate),
                                           frequency: event.frequency,
                                           endDate: endDate)
                    }
                 }
                 if newEvent.startDate > endDate {break}
                 repeatEvents.append(newEvent)
             }
        case .year:
            repeatEvents.append(event)
            while repeatEvents.last!.startDate < endDate {
                let eventYear = calendar.component(.year, from: repeatEvents.last!.startDate)
                if eventYear % 4 == 0 {
                    let newEvent = Action(name: event.name, amount: event.amount,
                                           direction: event.direction,
                                           startDate: Date.init(timeInterval: leapYear , since: repeatEvents.last!.startDate),
                                           frequency: event.frequency,
                                           endDate: endDate)
                    if newEvent.startDate > endDate {break}
                    repeatEvents.append(newEvent)
                } else {
                    let newEvent = Action(name: event.name, amount: event.amount,
                                           direction: event.direction,
                                           startDate: Date.init(timeInterval: year , since: repeatEvents.last!.startDate),
                                           frequency: event.frequency,
                                           endDate: endDate)
                    if newEvent.startDate > endDate {break}
                    repeatEvents.append(newEvent)
                }
            }
        }
         return repeatEvents
     }
}

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
        let actions = [Action(name: "First Action", amount: 10000, direction: true, startDate: dates[0], frequency: .week, endDate: dates[1]),
                       Action(name: "Second Action", amount: 100000, direction: false, startDate: dates[2], frequency: .year, endDate: dates[3]),
                       Action(name: "Third Action", amount: 1453839, direction: true, startDate: dates[4], frequency: .month, endDate: dates[5]),
                       Action(name: "Fourth Action", amount: 136578, direction: false, startDate: dates[6], frequency: .month, endDate: dates[7]),
                       Action(name: "Fifth Action", amount: 236793, direction: true, startDate: Date(), frequency: .none),
                       Action(name: "Sixth Action", amount: 265, direction: false, startDate: Date(), frequency: .month)]
        return actions
    }
}
