//
//  AlertHelper.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 16/07/24.
//

import Foundation

class AlertHelper {
    static let shared = AlertHelper()

    func setReminderIntervalTime(habitTime:Date, alert: String) -> Double {
        switch alert {
        case "At time of event":
            return getInterval(date: habitTime)
        case "5 minutes before":
            return getInterval(date: habitTime) + 5
        case "10 minutes before":
            return getInterval(date: habitTime) + 10
        default:
            return 0
        }
    }
    
    private func getInterval(date: Date) -> Double {
        return date.timeIntervalSinceNow
    }
}
