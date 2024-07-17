//
//  HabitViewModel.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 16/07/24.
//

import SwiftUI
import SwiftData

struct HabitViewModel: View {
//    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var habitService: SwiftDataHabitService
    @State private var selectedDate = Date()
    @State private var showAddHabit = false
    @State private var searchQuery = ""
    
    private var habitHelper = HabitHelper.shared
        
//    @Query(sort: \HabitModel.habitTime, order: .forward) private var allHabits: [HabitModel]
    
    @State private var allHabits: [HabitModel] = []
    
    private func refreshHabits() {
        allHabits = habitService.GetAllHabit()
        print("test-test", allHabits)
    }

    private var noteCount: Int {
        filteredHabits.count
    }
    
    private var todoCount: Int {
//        filteredTodo.count
        habitService.GetTotalTodoHabit()
    }
    
    private var completedCount: Int {
        habitService.GetTotalCompletedHabit()
    }
    
    var filteredHabits: [HabitModel] {
        if searchQuery.isEmpty {
            return allHabits
        }
        return habitService.GetHabitsByName(name: searchQuery)
        
    }
    
    var filteredTodo: [HabitModel] {
        habitService.GetToDoHabit(date: selectedDate)
    }
    
    var completedHabits: [HabitModel] {
        habitService.GetCompletedHabit(date: selectedDate)
    }
    
    var body: some View {
        NavigationStack {
            List {
                if filteredHabits.isEmpty {
                    EmptyView()
                } else {
                    TodoHabitsComponent(todos: filteredTodo, selectedDate: selectedDate)
                    
                    CompletedHabitComponent(completed: completedHabits)
                    
                    HabitListViewModel(habits: filteredHabits)
                }
            }
            .onAppear(perform: {
                refreshHabits()
            })
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
            .sheet(isPresented: $showAddHabit) {
                NavigationStack {
                    AddHabitView()
                }
                .presentationDetents([.large])
            }
        }
        .searchable(text: $searchQuery, prompt: "Search")
    }
}



//class HabitViewModel: ObservableObject {
//    @EnvironmentObject var habitService: SwiftDataHabitService
//    @State private var selectedDate = Date()
//    @State private var searchQuery = ""
//    private let helperHabit = HabitHelper.shared
//        
//    private var allHabits: [HabitModel] = []
//    
//    func fetchAllHabits() {
//       allHabits = habitService.GetAllHabit()
//    }
//    
//    func fetchToDoHabits() -> [HabitModel] {
//        return habitService.GetToDoHabit(date: selectedDate)
//    }
//    
//    func fetchCompletedHabits() -> [HabitModel] {
//       return habitService.GetCompletedHabit(date: selectedDate)
//    }
//    
//    func fetchHabitDetailId(id: String) -> HabitModel! {
//        return habitService.GetHabitDetailById(id: id) ?? nil
//    }
//    
//    func fetchHabitDetailByName(name: String)-> [HabitModel] {
//        return habitService.GetHabitDetailByName(name: name)
//    }
//
//    func getTotalHabit() {
////        totalHabit = habitService.GetTotalHabit()
//    }
//    
//    func getTotalTodoHabit() -> Int {
//        return habitService.GetTotalHabit()
//    }
//
//    func getTotalCompletedHabit() -> Int {
//       return habitService.GetTotalHabit()
//    }
//
//
//    func insertHabit(data: HabitModel) {
//        habitService.Insert(data: data)
//    }
//    
//    func insertHabits(data: [HabitModel]) {
//        habitService.InsertMany(data: data)
//    }
//    
//    private var noteCount: Int {
//        filteredHabits.count
//    }
//    
//    private var todoCount: Int {
//        getTotalTodoHabit()
//    }
//    
//    private var completedCount: Int {
//        getTotalCompletedHabit()
//    }
//    
//    var filteredHabits: [HabitModel] {
//        if searchQuery.isEmpty {
//            return allHabits
//        }
//        
//        return fetchHabitDetailByName(name: searchQuery)
//    }
//    
//    var filteredTodo: [HabitModel] {
//        let uncompletedHabits = allHabits.filter { !$0.habitIsCompleted && helperHabit.isHabitDueToday(habit: $0) }
//        
//        if searchQuery.isEmpty {
//            return uncompletedHabits
//        }
//        
//        return uncompletedHabits.filter { todo in
//            todo.habitName.range(of: searchQuery, options: .caseInsensitive) != nil
//        }
//    }
//    
//    var completedHabits: [HabitModel] {
//        let completed = allHabits.filter { $0.habitIsCompleted && helperHabit.isHabitDueToday(habit: $0) }
//        
//        if searchQuery.isEmpty {
//            return completed
//        }
//        
//        let filteredCompleted = completed.compactMap { habit in
//            let habitContainsQuery = habit.habitName.range(of: searchQuery, options: .caseInsensitive) != nil
//            
//            return habitContainsQuery ? habit : nil
//        }
//        
//        return filteredCompleted
//    }
//}
