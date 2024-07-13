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
	
	private var todoCount: Int {
		filteredTodo.count
	}
	
	private var completedCount: Int {
		completedHabits.count
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
	
	var filteredTodo: [HabitModel] {
		let uncompletedHabits = allHabits.filter { !$0.habitIsCompleted && Calendar.current.isDateInToday($0.habitTime) }
		
		if searchQuery.isEmpty {
			return uncompletedHabits
		}
		
		let filteredTodo = uncompletedHabits.compactMap { todo in
			let todoContainsQuery = todo.habitName.range(of: searchQuery, options: .caseInsensitive) != nil
			
			return todoContainsQuery ? todo : nil
		}
		
		return filteredTodo
	}
	
	var completedHabits: [HabitModel] {
		let completed = allHabits.filter { $0.habitIsCompleted && Calendar.current.isDateInToday($0.habitTime) }
		
		if searchQuery.isEmpty {
			return completed
		}
		
		let filteredCompleted = completed.compactMap { habit in
			let habitContainsQuery = habit.habitName.range(of: searchQuery, options: .caseInsensitive) != nil
			
			return habitContainsQuery ? habit : nil
		}
		
		return filteredCompleted
	}
	
    var body: some View {
		NavigationStack {
			List {
				if filteredHabits.isEmpty {
					EmptyView()
				} else {
					Section {
						Text("Today's To-do Habits")
							.font(.title2)
							.fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
						
						Text("\(todoCount) remaining")
							.font(.callout)
							.foregroundStyle(.secondary)
							.offset(y: -15)
						
						ForEach(filteredTodo) { todo in
							HStack {
								Button {
									
									withAnimation {
										todo.habitIsCompleted.toggle()
									}
									
								} label: {
									Image(systemName: "circle")
										.symbolVariant(todo.habitIsCompleted ? .fill : .none)
										.font(.headline)
								}
								.buttonStyle(.plain)
								.padding(.trailing, 8)
								
								VStack(alignment: .leading) {
									Text(todo.habitName)
										.font(.headline)
										.fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
									
									Text(todo.habitTime, format: Date.FormatStyle(time: .shortened))
										.font(.callout)
										.foregroundStyle(.secondary)
								}
							}
							.offset(y: -15)
						}
						
						if completedHabits.isEmpty {
							EmptyView()
						} else {
							Text("Completed (\(completedCount))")
								.font(.title2)
								.fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
							
							ForEach(completedHabits) { completed in
								HStack {
									Button {
										
										withAnimation {
											completed.habitIsCompleted.toggle()
										}
										
									} label: {
										Image(systemName: "circle")
											.symbolVariant(completed.habitIsCompleted ? .fill : .none)
											.foregroundStyle(completed.habitIsCompleted ? Color.accentColor : .primary)
											.font(.headline)
									}
									.buttonStyle(.plain)
									.padding(.trailing, 8)
									
									VStack(alignment: .leading) {
										Text(completed.habitName)
											.font(.headline)
											.fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
											.strikethrough(completed.habitIsCompleted)
											.foregroundStyle(completed.habitIsCompleted ? .secondary : .primary)
										
										Text(completed.habitTime, format: Date.FormatStyle(time: .shortened))
											.font(.callout)
											.foregroundStyle(.secondary)
									}
								}
							}
						}
					}
					.listRowSeparator(.hidden)
					
					Section {
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
					} header: {
						Text("All Habits")
							.font(.headline)
					} footer: {
						Text("The times shown above are the times you had set for the goal.")
					}
				}
			}
			.navigationTitle("Habit Tracking Notes")
			.toolbar {
				ToolbarItemGroup(placement: .primaryAction) {
					Button(action: {
						print("Option button is pressed.")
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
