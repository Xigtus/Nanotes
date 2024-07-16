//
//  HabitRowViewModel.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 16/07/24.
//

import SwiftUI

struct HabitRowComponent: View {
    var habit: HabitModel

    var body: some View {
        HStack {
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
                
                Text(habit.habitRepeat)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
