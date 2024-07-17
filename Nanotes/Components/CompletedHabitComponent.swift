//
//  CompletedHabitComponent.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 16/07/24.
//

import SwiftUI

struct CompletedHabitComponent: View {
    var completed: [HabitModel]
    var body: some View {
        if !completed.isEmpty {
            Section {
                Text("Completed (\(completed.count))")
                    .font(.title2)
                    .fontWeight(.bold)
                
                ForEach(completed) { habit in
                    HabitCompletedRowComponent(habit: habit)
                }
            }
        }
    }
}
