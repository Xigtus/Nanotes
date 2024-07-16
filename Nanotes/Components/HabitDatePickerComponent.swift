//
//  HabitDatePickerComponent.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 15/07/24.
//

import SwiftUI

struct HabitDatePickerComponent: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @Binding var startDate: Date
    @Binding var endDate: Date
    
    var body: some View {
        Section {
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
        }
    }
}

//#Preview {
//    HabitDatePickerComponent()
//}
