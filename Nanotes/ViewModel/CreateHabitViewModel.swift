//
//  CreateHabitViewModel.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 15/07/24.
//

import SwiftUI

struct CreateHabitViewModel: View {
    @Environment(\.dismiss) var dismiss
//    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var habitService: SwiftDataHabitService
    
    
    @Binding var data: HabitModel
    
    var body: some View {
        List {
            HabitNameComponent(habitName: $data.habitName)
            
            HabitDatePickerComponent(startDate: $data.habitStartDate, endDate: $data.habitEndDate)
            
            HabitRepeatComponent(repeatType: $data.habitRepeat, habitDate: $data.habitTime)
            
            HabitAlertComponent(data: $data)
            
        }
        .navigationTitle("New Habit")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    withAnimation {
//                        modelContext.insert(data)
                        habitService.Insert(data: data)
                    }
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}
