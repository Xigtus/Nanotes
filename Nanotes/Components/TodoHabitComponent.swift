//
//  TodoHabitComponent.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 16/07/24.
//

import SwiftUI

struct TodoHabitsComponent: View {
    var todos: [HabitModel]

    var body: some View {
        Section {
            Text("Today's To-do Habits")
                .font(.title2)
                .fontWeight(.bold)

            Text("\(todos.count) remaining")
                .font(.callout)
                .foregroundStyle(.secondary)
                .offset(y: -15)

            ForEach(todos) { todo in
                HabitTodoRowComponent(habit: todo)
            }
        }
    }
}
