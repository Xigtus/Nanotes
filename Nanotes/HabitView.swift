//
//  ContentView.swift
//  Nanotes
//
//  Created by Gusti Rizky Fajar on 10/07/24.
//

import SwiftUI
import SwiftData

struct HabitView: View {
	
	@Environment(\.modelContext) var modelContext
	
	@State private var showAddHabit = false
	@State private var searchQuery = ""
	
	@Query(sort: \HabitModel.habitTime, order: .forward) private var allHabits: [HabitModel]
	
	private var noteCount: Int {
		filteredHabits.count
	}
	
	var filteredHabits: [HabitModel] {
		if searchQuery.isEmpty {
			return allHabits
		}
		
		let filteredHabits = allHabits.compactMap { habit in
			let habitContainsQuery = habit.habitName.range(of: searchQuery, options: .caseInsensitive) != nil
			
			return habitContainsQuery ? habit : nil
		}
		
		return filteredHabits
	}
	
    var body: some View {
		NavigationStack {
			List {
				if filteredHabits.isEmpty {
					EmptyView()
				} else {
					Section("All Habits") {
						ForEach(filteredHabits) { habit in
							HStack {
								VStack(alignment: .leading) {
									Text(habit.habitName)
										.font(.headline)
										.fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
									
									Text(habit.habitTime, format: Date.FormatStyle(time: .shortened))
										.font(.callout)
										.foregroundStyle(.secondary)
									
									Text(habit.habitRepeat)
										.font(.callout)
										.foregroundStyle(.secondary)
								}
							}
							.swipeActions {
								Button(role: .destructive) {
									
									withAnimation {
										modelContext.delete(habit)
									}
									
								} label: {
									Label("Delete", systemImage: "trash")
										.symbolVariant(/*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
								}
							}
						}
					}
				}
			}
			.navigationTitle("Habit Tracking Notes")
			.toolbar {
				ToolbarItemGroup(placement: .primaryAction) {
					Button(action: {
						
					}, label: {
						Label("Options", systemImage: "ellipsis.circle")
					})
				}
				
				ToolbarItemGroup(placement: .bottomBar) {
					Spacer()
					Text ("\(noteCount) Notes")
						.font(.caption)
					Spacer()
					Button(action: {
						showAddHabit.toggle()
					}, label: {
						Label("Add Habit", systemImage: "square.and.pencil")
					})
				}
			}
			.sheet(isPresented: $showAddHabit,
				   content: {
				NavigationStack {
					AddHabitView()
				}
				.presentationDetents([.large])
			})
		}
		.searchable(text: $searchQuery, prompt: "Search")
    }
}

#Preview {
    HabitView()
}
