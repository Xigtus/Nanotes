//
//  HabitDetailView.swift
//  Nanotes
//
//  Created by Alifiyah Ariandri on 15/07/24.
//
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
//    @State var isCreatingNew = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Image(systemName: "flame")
                            .font(.title2)
                            .padding(.trailing, -3)
                            .foregroundStyle(Color.pink)
                        
                        Text("\(habit.habitStreak)")
                            .font(.title2)
                            .foregroundStyle(Color.pink)
                    }
                    .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
//                DatePicker("Habit Streak", selection: $selectedDate, displayedComponents: .date)
//                    .datePickerStyle(.graphical)
//                    .padding(.horizontal, 20)
                
                FSCalendarView(selectedDate: $selectedDate, habit: $habit)
                    .frame(height: 300)
                    .padding(.horizontal)
                
                Divider().padding(.horizontal, 20)
                
                VStack {
                    HStack {
                        Text("TODAY")
                            .bold()
                        Text(selectedDate.formatted(date: .abbreviated, time: .omitted))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.accentColor)
                .padding()
                
                HNotePerDayView(habit: habit, date: selectedDate)
            }
            .navigationTitle("\(habit.habitName)")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Created on \(habit.habitTime.formatted(date: .abbreviated, time: .omitted))")
                            .font(.subheadline).foregroundStyle(.secondary)
                        Text("Habit will occur \(habit.habitRepeat.lowercased())")
                            .font(.subheadline).foregroundStyle(.secondary)
                    }
                }
            }
//            .onChange(of: isCreatingNew) {}
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
//    TestHabitDetailView()
// }
