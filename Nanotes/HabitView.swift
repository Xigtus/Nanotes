//
//  ContentView.swift
//  Nanotes
//
//  Created by Gusti Rizky Fajar on 10/07/24.
//

import SwiftData
import SwiftUI

struct HabitView: View {
    @Environment(\.modelContext) var modelContext
	
    @State private var showAddHabit = false
    @State private var searchQuery = ""
    
    @State private var lastViewedDate: Date?
	
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
        let uncompletedHabits = allHabits.filter { !$0.habitIsCompleted && isHabitDueToday(habit: $0) }
		
        if searchQuery.isEmpty {
            return uncompletedHabits
        }
		
        return uncompletedHabits.filter { todo in
            todo.habitName.range(of: searchQuery, options: .caseInsensitive) != nil
        }
    }
	
    var completedHabits: [HabitModel] {
        let completed = allHabits.filter { $0.habitIsCompleted && isHabitDueToday(habit: $0) }
		
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
                            .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
						
                        Text("\(todoCount) remaining")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .offset(y: -15)
						
                        ForEach(filteredTodo) { todo in
                            HStack {
                                Button {
                                    withAnimation {
                                        todo.habitIsCompleted.toggle()
                                        todo.habitCompletionDates.append(Date())
                                        updateNoteHabit(for: todo)
                                        updateStreak(for: todo)
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
                                        .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
									
                                    HStack {
                                        Text(todo.habitTime, format: Date.FormatStyle(time: .shortened))
                                            .font(.callout)
                                            .foregroundStyle(.secondary)
                                            .padding(.trailing, 3)
										
                                        Image(systemName: "flame")
                                            .font(.callout)
                                            .padding(.trailing, -3)
                                            .foregroundStyle(Color.pink)
										
                                        Text("\(todo.habitStreak)")
                                            .font(.callout)
                                            .foregroundStyle(Color.pink)
                                    }
                                }
                            }
                            .offset(y: -15)
                        }
						
                        if completedHabits.isEmpty {
                            EmptyView()
                        } else {
                            Text("Completed (\(completedCount))")
                                .font(.title2)
                                .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
							
                            ForEach(completedHabits) { completed in
                                HStack {
                                    Button {
                                        withAnimation {
                                            completed.habitIsCompleted.toggle()
                                            updateStreak(for: completed)
                                            resetCompletionStatus(for: completed)
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
                                            .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
                                            .strikethrough(completed.habitIsCompleted)
                                            .foregroundStyle(completed.habitIsCompleted ? .secondary : .primary)
										
                                        HStack {
                                            Text(completed.habitTime, format: Date.FormatStyle(time: .shortened))
                                                .font(.callout)
                                                .foregroundStyle(.secondary)
                                                .padding(.trailing, 3)
											
                                            Image(systemName: "flame")
                                                .font(.callout)
                                                .padding(.trailing, -3)
                                                .foregroundStyle(Color.pink)
											
                                            Text("\(completed.habitStreak)")
                                                .font(.callout)
                                                .foregroundStyle(Color.pink)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
					
                    Section {
                        ForEach(filteredHabits) { habit in
                            NavigationLink {
                                HabitDetailView(habit: habit)
                            } label: {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(habit.habitName)
                                            .font(.headline)
                                            .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
                                        
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
                                .swipeActions {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            modelContext.delete(habit)
                                        }
                                        
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                            .symbolVariant(/*@START_MENU_TOKEN@*/ .fill/*@END_MENU_TOKEN@*/)
                                    }
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
                    Text("\(noteCount) Notes")
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
            .onAppear {
                let today = Calendar.current.startOfDay(for: Date())
                        
                if lastViewedDate == nil || Calendar.current.isDate(lastViewedDate!, inSameDayAs: today) == false {
                    for habit in allHabits {
                        if isHabitDueToday(habit: habit) {
                            resetCompletionStatus(for: habit)
                        }
                    }
                    lastViewedDate = today
                }
            }
        }
        .searchable(text: $searchQuery, prompt: "Search")
    }
	
    func isHabitDueToday(habit: HabitModel) -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date()) // Start of today
		
        let habitTime = calendar.startOfDay(for: habit.habitTime)
		
        switch habit.habitRepeat.lowercased() {
            case "every day":
                // Check if habitTime is today
                if Date() >= habitTime {
                    return true
                }
                return false
            case "every week":
                let habitDay = calendar.component(.weekday, from: habit.habitTime)
                let todayDay = calendar.component(.weekday, from: today)
                return habitDay == todayDay
            default:
                return false
        }
    }
	
    func updateStreak(for habit: HabitModel) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
		
        guard let lastDate = habit.habitLastCompletionDate else {
            if habit.habitIsCompleted {
                habit.habitStreak += 1
                habit.habitLastCompletionDate = today
            }
            return
        }
		
        let lastCompletion = calendar.startOfDay(for: lastDate)
        let daysDifference = calendar.dateComponents([.day], from: lastCompletion, to: today).day ?? 0
        let weeksDifference = calendar.dateComponents([.weekOfYear], from: lastCompletion, to: today).weekOfYear ?? 0
		
        if habit.habitIsCompleted {
            if habit.habitRepeat.lowercased() == "every day" {
                if daysDifference == 1 {
                    habit.habitStreak += 1
                    habit.habitLastCompletionDate = today
                } else if daysDifference > 1 {
                    habit.habitStreak = 1
                    habit.habitLastCompletionDate = today
                }
            } else if habit.habitRepeat.lowercased() == "every week" {
                if weeksDifference == 1 {
                    habit.habitStreak += 1
                    habit.habitLastCompletionDate = today
                } else if weeksDifference > 1 {
                    habit.habitStreak = 1
                    habit.habitLastCompletionDate = today
                }
            }
        } else {
            if daysDifference == 0 || (habit.habitRepeat.lowercased() == "every week" && weeksDifference == 0) {
                habit.habitStreak -= 1
                habit.habitLastCompletionDate = nil
            }
        }
    }
    
    func updateNoteHabit(for habit: HabitModel) {
        let calendar = Calendar.current

        let today = calendar.startOfDay(for: Date())
        let note = HNoteModel(lastModified: Date(), habit: habit, date: today, content: "New Note")
        
        modelContext.insert(note)
    }
	
    func resetCompletionStatus(for habit: HabitModel) {
        let calendar = Calendar.current
        let today = Date()
		
        switch habit.habitRepeat.lowercased() {
            case "every day":
                habit.habitIsCompleted = false
            case "every week":
                let habitDay = calendar.component(.weekday, from: habit.habitTime)
                let todayDay = calendar.component(.weekday, from: today)
                if habitDay == todayDay {
                    habit.habitIsCompleted = false
                }
            default:
                break
        }
    }
}

#Preview {
    HabitView()
}
