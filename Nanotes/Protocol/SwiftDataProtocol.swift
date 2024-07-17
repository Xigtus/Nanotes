//
//  GetDataProtocol.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 16/07/24.
//

import Foundation
import SwiftData

protocol SwiftDataHabitProtocols {
    func GetAllHabit() -> [HabitModel]
    func GetCompletedHabit(date: Date) -> [HabitModel]
    func GetToDoHabit(date: Date) -> [HabitModel]
    func GetHabitDetailById(id: String) -> HabitModel?
    func GetHabitsByName(name: String) -> [HabitModel]
    func GetTotalHabit() -> Int
    func GetTotalTodoHabit() -> Int
    func GetTotalCompletedHabit() -> Int
    
    func Insert(data: HabitModel)
    func InsertMany(data: [HabitModel])
    
    func Delete(data: HabitModel)
}

class SwiftDataHabitService: ObservableObject, SwiftDataHabitProtocols {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    private var habitHelper = HabitHelper.shared

    @MainActor
    init() {
        self.modelContainer = try! ModelContainer(for: HabitModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
        HabitHelper.shared.habitService = self
    }
    
    func GetAllHabit() -> [HabitModel] {
        do {
            return try modelContext.fetch(FetchDescriptor<HabitModel>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func GetCompletedHabit(date: Date) -> [HabitModel] {
        let allHabits = GetAllHabit()
        return allHabits.filter { $0.habitIsCompleted && habitHelper.isHabitDueToday(habit: $0) }
    }
    
    func GetToDoHabit(date: Date) -> [HabitModel] {
        let allHabits = GetAllHabit()
//        return allHabits.filter { !$0.habitIsCompleted && date >= $0.habitTime}
        return allHabits.filter { !$0.habitIsCompleted && habitHelper.isHabitDueToday(habit: $0) }
    }
    
    func GetHabitDetailById(id: String) -> HabitModel? {
        let allHabits = GetAllHabit()
        return allHabits.first { $0.uuid == id }
    }
    
    func GetHabitsByName(name: String) -> [HabitModel] {
        let allHabits = GetAllHabit()
        return allHabits.filter {
            $0.habitName.range(of: name, options: .caseInsensitive) != nil
        }
    }
    
    func GetTotalHabit() -> Int {
        let allHabits = GetAllHabit()
        return allHabits.count
    }
    
    func GetTotalTodoHabit() -> Int {
        let allHabits = GetToDoHabit(date: Date())
        return allHabits.count
    }

    func GetTotalCompletedHabit() -> Int {
        let allHabits = GetCompletedHabit(date: Date())
        return allHabits.count
    }

    func Insert(data: HabitModel) {
        modelContext.insert(data)
    }
    
    func Insert(data: HNoteModel) {
        modelContext.insert(data)
    }
    
    func InsertMany(data: [HabitModel]) {
        for habit in data {
            Insert(data: habit)
        }
    }
    
    func Delete(data: HabitModel) {
        modelContext.delete(data)
    }
}
