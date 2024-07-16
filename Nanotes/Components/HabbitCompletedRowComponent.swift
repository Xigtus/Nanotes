//
//  HabbitCompletedRowViewModel.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 16/07/24.
//

import SwiftUI

struct HabitCompletedRowComponent: View {
    @Environment(\.modelContext) var modelContext
    @State var habit: HabitModel

    var body: some View {
        HStack {
            Button {
                withAnimation {
                    habit.habitIsCompleted.toggle()
                    updateStreak(for: habit)
                    resetCompletionStatus(for: habit)
                }
            } label: {
                Image(systemName: "circle")
                    .symbolVariant(habit.habitIsCompleted ? .fill : .none)
                    .foregroundStyle(habit.habitIsCompleted ? Color.accentColor : .primary)
                    .font(.headline)
            }
            .buttonStyle(.plain)
            .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(habit.habitName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .strikethrough(habit.habitIsCompleted)
                    .foregroundStyle(habit.habitIsCompleted ? .secondary : .primary)
                
                HStack {
                    Text(habit.habitTime, format: Date.FormatStyle(time: .shortened))
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .padding(.trailing, 3)
                    
                    Image(systemName: "flame")
                        .font(.callout)
                        .padding(.trailing, -3)
                        .foregroundStyle(Color.pink)
                    
                    Text("\(habit.habitStreak)")
                        .font(.callout)
                        .foregroundStyle(Color.pink)
                }
            }
        }
    }

    func updateStreak(for habit: HabitModel) {
        // Function implementation
    }

    func resetCompletionStatus(for habit: HabitModel) {
        // Function implementation
    }
}
