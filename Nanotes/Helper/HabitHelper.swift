//
//  HabitHelper.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 15/07/24.
//

import Foundation

class HabitHelper {
    static let shared = HabitHelper()
    
    func isHabitDueToday(habit: HabitModel) -> Bool {
        let calendar = Calendar.current
        let today = Date()
        
        switch habit.habitRepeat.lowercased() {
            case "every day":
                return true
            case "every week":
                let habitDay = calendar.component(.weekday, from: habit.habitTime)
                let todayDay = calendar.component(.weekday, from: today)
                return habitDay == todayDay
            default:
                return false
        }
    }
    
    func updateStreak(for habit: HabitModel) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        guard let lastDate = habit.habitLastCompletionDate else {
            if habit.habitIsCompleted {
                habit.habitStreak += 1
                habit.habitLastCompletionDate = today
            }
            return
        }
        
        let lastCompletion = calendar.startOfDay(for: lastDate)
        let daysDifference = calendar.dateComponents([.day], from: lastCompletion, to: today).day ?? 0
        
        if habit.habitIsCompleted {
            if daysDifference == 1 {
                habit.habitStreak += 1
                habit.habitLastCompletionDate = today
            } else if daysDifference > 1 {
                habit.habitStreak = 1
                habit.habitLastCompletionDate = today
            }
        } else {
            if daysDifference == 0 {
                habit.habitStreak -= 1
                habit.habitLastCompletionDate = nil
            }
        }
    }
    
    func resetCompletionStatus(for habit: HabitModel) {
        let calendar = Calendar.current
        let today = Date()
        
        switch habit.habitRepeat.lowercased() {
            case "every day":
                habit.habitIsCompleted = false
            case "every week":
                let habitDay = calendar.component(.weekday, from: habit.habitTime)
                let todayDay = calendar.component(.weekday, from: today)
                if habitDay != todayDay {
                    habit.habitIsCompleted = false
                }
            default:
                break
        }
    }
}


