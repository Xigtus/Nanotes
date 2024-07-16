//
//  HabitNameComponent.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 15/07/24.
//

import SwiftUI

struct HabitNameComponent: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @Binding var habitName: String
    
    var body: some View {
        Section {
            HStack {
                Text("Habit")
                    .padding(.trailing, 20)
                TextField("Habit name", text: $habitName)
            }
        }
    }
}
