//
//  HabitDetailView.swift
//  Nanotes
//
//  Created by Alifiyah Ariandri on 15/07/24.
//

import SwiftUI

struct HabitDetailView: View {
    @State private var selectedDate = Date()

    @State var habit: HabitModel
    @State var isCreatingNew = false

    var body: some View {
        NavigationView {
            ScrollView {
                FSCalendarView(selectedDate: $selectedDate, habit: $habit)
                    .frame(height: 338)

                Divider()

                HStack {
                    Text("Today")
                    Text(selectedDate.formatted("dd MMMM yyyy"))
                }.foregroundColor(.accentColor)

                HNotePerDayView(habit: habit, date: selectedDate)

            }.navigationTitle("\(habit.habitName)")
                .onChange(of: isCreatingNew) {}
//                .onAppear {
//                    habit.addNotes()
//                }
        }
    }
}

extension Date {
    func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

// #Preview {
//    HabitDetailView(habit: HabitModel())
// }
