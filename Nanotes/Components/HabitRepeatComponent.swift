//
//  HabitRepeatComponent.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 15/07/24.
//

import SwiftUI

struct HabitRepeatComponent: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @Binding var repeatType: String
    @Binding var habitDate: Date
    
    var body: some View {
        Section("Repeat Option") {
            Picker("Repeat", selection: $repeatType) {
                ForEach(repeatFrequency, id: \.self) { habit in
                    Text(habit).tag(habit)
                }
            }
            
            DatePicker("Time", selection: $habitDate, displayedComponents: .hourAndMinute)
        }

    }
}
