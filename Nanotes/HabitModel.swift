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

    @Relationship(deleteRule: .cascade, inverse: \HNoteModel.habit) var notes: [HNoteModel]

    init(habitName: String = "",
         habitStartDate: Date = .now,
         habitRepeat: String = "Every Day",
         habitTime: Date = .now,
         habitAlert: String = "None",
         habitIsCompleted: Bool = false,
         habitStreak: Int = 0,
         lastCompletionDate: Date? = nil,
         notes: [HNoteModel] = [])
    {
        self.habitName = habitName
        self.habitStartDate = habitStartDate
        self.habitRepeat = habitRepeat
        self.habitTime = habitTime
        self.habitAlert = habitAlert
        self.habitIsCompleted = habitIsCompleted
        self.habitStreak = habitStreak
        self.habitLastCompletionDate = lastCompletionDate
        self.notes = []
    }

    static func getDateFromString(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: dateString) else {
            return nil
        }

        return date
    }

    func addNotes() {
        // Dummy Note
        let note = HNoteModel(lastModified: HabitModel.getDateFromString("2024-06-29 06:30:00")!, habit: self, date: HabitModel.getDateFromString("2024-06-27 06:30:00")!, content: "Hello this is note from June 27, i write this note as dummy data 1")
        modelContext?.insert(note)
    }

    func getNotesByDate(_ date: Date) -> [HNoteModel] {
        return notes.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }
}
