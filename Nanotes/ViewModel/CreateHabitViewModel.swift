//
//  CreateHabitViewModel.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 15/07/24.
//

import SwiftUI

struct CreateHabitViewModel: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Binding var data: HabitModel
    
    var body: some View {
        List {
            HabitNameComponent(habitName: $data.habitName)
            
            HabitDatePickerComponent(startDate: $data.habitStartDate, endDate: $data.habitEndDate)
            
            HabitRepeatComponent(repeatType: $data.habitRepeat, habitDate: $data.habitTime)
            
            HabitAlertComponent(habitAlert: $data.habitAlert)
        }
        .navigationTitle("New Habit")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    withAnimation {
                        modelContext.insert(data)
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
