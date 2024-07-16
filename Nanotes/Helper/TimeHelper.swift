//
//  TimeHelper.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 15/07/24.
//

import Foundation

class TimeHelper {
    static let shared = TimeHelper()
    
    private init() {}
    
    func formatTimeToString(_ format: String, date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
