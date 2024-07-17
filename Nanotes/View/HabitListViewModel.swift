//
//  HabitListView.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 16/07/24.
//

import SwiftUI

struct HabitListViewModel: View {
    @EnvironmentObject var habitService: SwiftDataHabitService

    var habits: [HabitModel]
    var body: some View {
        Section {
            ForEach(habits) { habit in
                NavigationLink {
                    HabitDetailView(habit: habit)
                } label: {
                    HabitRowComponent(habit: habit)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        withAnimation {
                            habitService.Delete(data: habit)
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                            .symbolVariant(.fill)
                    }
                }
            }
        } header: {
            Text("All Habits")
                .font(.headline)
        } footer: {
            Text("The times shown above are the times you had set for the goal.")
        }
    }
}

