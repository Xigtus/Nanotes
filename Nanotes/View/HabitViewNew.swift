//
//  HabitViewNew.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 15/07/24.
//

import SwiftUI
import SwiftData

struct HabitViewNew: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \HabitModel.habitTime, order: .forward) private var allHabits: [HabitModel]

    var body: some View {
        AddHabitView()
    }
}

#Preview {
    HabitViewNew()
}
