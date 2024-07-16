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
    func GetHabitDetailByName(name: String) -> [HabitModel]
    func GetTotalHabit() -> Int
    func GetTotalTodoHabit() -> Int
    func GetTotalCompletedHabit() -> Int
    
    func Insert(data: HabitModel)-> Error?
    func InsertMany(data: [HabitModel]) -> Error?
}

class SwiftDataHabitService: ObservableObject, SwiftDataHabitProtocols {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    init() {
        self.modelContainer = try! ModelContainer(for: HabitModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
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
        return allHabits.filter { $0.habitIsCompleted && date == $0.habitStartDate}
    }
    
    func GetToDoHabit(date: Date) -> [HabitModel] {
        let allHabits = GetAllHabit()
        return allHabits.filter { $0.habitIsCompleted && date == $0.habitStartDate}
    }
    
    func GetHabitDetailById(id: String) -> HabitModel? {
        let allHabits = GetAllHabit()
        return allHabits.first { $0.uuid == id}
    }
    
    func GetHabitDetailByName(name: String) -> [HabitModel] {
        let allHabits = GetAllHabit()
        return allHabits.filter { $0.habitName == name}
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

    
    func Insert(data: HabitModel) -> Error? {
        return modelContext.insert(data) as? Error
    }
    
    func InsertMany(data: [HabitModel]) -> Error? {
        var errors: [Error] = []
            
            for habit in data {
                if let error = Insert(data: habit) {
                    errors.append(error)
                }
            }
            
        return errors as? Error
    }
}
