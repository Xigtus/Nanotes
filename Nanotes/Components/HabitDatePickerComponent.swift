//
//  HabitDatePickerComponent.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 15/07/24.
//

import SwiftUI

struct HabitDatePickerComponent: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    var body: some View {
        Section {
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
        }
    }
}
