//
//  HabitTodoRowViewModel.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 16/07/24.
//

import SwiftUI

struct HabitTodoRowComponent: View {
    @State var habit: HabitModel
    
    private let habitHelper = HabitHelper.shared
    
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    habit.habitIsCompleted.toggle()
                    habitHelper.updateStreak(for: habit)
                }
            } label: {
                Image(systemName: "circle")
                    .symbolVariant(habit.habitIsCompleted ? .fill : .none)
                    .font(.headline)
            }
            .buttonStyle(.plain)
            .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(habit.habitName)
                    .font(.headline)
                    .fontWeight(.bold)
                
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
        .offset(y: -15)
    }
}

