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
    var habitEndDate: Date
    var habitRepeat: String
    var habitTime: Date
    var habitAlert: String
    var habitIsCompleted: Bool
    var habitStreak: Int
    var habitLastCompletionDate: Date?
    var habitCompletionDates: [Date]

    @Relationship(deleteRule: .cascade, inverse: \HNoteModel.habit) var notes: [HNoteModel]

    init(habitName: String = "",
         habitStartDate: Date = .now,
         habitEndDate: Date = .now,
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
        self.habitEndDate = habitEndDate
        self.habitRepeat = habitRepeat
        self.habitTime = habitTime
        self.habitAlert = habitAlert
        self.habitIsCompleted = habitIsCompleted
        self.habitStreak = habitStreak
        self.habitLastCompletionDate = lastCompletionDate
        self.notes = []
        self.habitCompletionDates = []
    }

    static func getDateFromString(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: dateString) else {
            return nil
        }

        return date
    }

    func iterateDates(from startDate: Date, to endDate: Date, calendar: Calendar = .current) -> [Date] {
        var dates: [Date] = []
        var currentDate = startDate

        while currentDate <= endDate {
            dates.append(currentDate)
            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else { break }
            currentDate = nextDate
        }

        return dates
    }

    func addNotes() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        let startDate = self.habitStartDate
        let endDate = self.habitEndDate

        let dates = self.iterateDates(from: startDate, to: endDate)
        print(dates)

        for date in dates {
            let note = HNoteModel(lastModified: Date(), habit: self, date: date, content: "Note for \(dateFormatter.string(from: date))")
            modelContext?.insert(note)
        }

        do {
            try modelContext?.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }

    func getNotesByDate(_ date: Date) -> [HNoteModel] {
        return self.notes.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }

    func getCompletionDates() -> [Date] {
        for note in self.notes {
            self.habitCompletionDates.append(note.date)
        }

        return self.habitCompletionDates
    }
}
