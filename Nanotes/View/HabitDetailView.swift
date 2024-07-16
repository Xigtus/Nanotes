//
//  HabitDetailView.swift
//  Nanotes
//
//  Created by Alifiyah Ariandri on 15/07/24.
//

import SwiftUI

struct HabitDetailView: View {
    @State private var selectedDate = Date()
    
    private var timeHelper = TimeHelper.shared

    @State var habit: HabitModel

    init(habit: HabitModel) {
            self._habit = State(initialValue: habit)
        }

    
    var body: some View {
        NavigationView {
            ScrollView {
                FSCalendarView(selectedDate: $selectedDate)
                    .frame(height: 338)

                Divider()
                
                HStack {
                    Text("Today")
                    Text(timeHelper.formatTimeToString("dd MMMM yyyy", date: selectedDate))
                }.foregroundColor(.accentColor)

                HNotePerDayView(habit: habit, date: selectedDate)

            }.navigationTitle("\(habit.habitName)")
        }
    }
}
