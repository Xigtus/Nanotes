//
//  HabitModel.swift
//  Nanotes
//
//  Created by Gusti Rizky Fajar on 11/07/24.
//

import Foundation
import SwiftData

@Model
final class HabitModel {
	var habitName: String
	var habitStartDate: Date
	var habitRepeat: String
	var habitTime: Date
	var habitAlert: String
	var habitIsCompleted: Bool
	var habitStreak: Int
	var habitLastCompletionDate: Date?
	
	init(habitName: String = "",
		 habitStartDate: Date = .now,
		 habitRepeat: String = "Every Day",
		 habitTime: Date = .now,
		 habitAlert: String = "None",
		 habitIsCompleted: Bool = false,
		 habitStreak: Int = 0,
		 lastCompletionDate: Date? = nil) {
		self.habitName = habitName
		self.habitStartDate = habitStartDate
		self.habitRepeat = habitRepeat
		self.habitTime = habitTime
		self.habitAlert = habitAlert
		self.habitIsCompleted = habitIsCompleted
		self.habitStreak = habitStreak
		self.habitLastCompletionDate = habitLastCompletionDate
	}
}
