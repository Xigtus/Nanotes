//
//  HabitNameComponent.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 15/07/24.
//

import SwiftUI

struct HabitNameComponent: View {
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
