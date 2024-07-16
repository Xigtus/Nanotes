//
//  HNotePerDayView.swift
//  Nanotes
//
//  Created by Alifiyah Ariandri on 15/07/24.
//

import SwiftUI

struct HNotePerDayView: View {
    var habit: HabitModel
    var date: Date

    @State var note: HNoteModel?

    var body: some View {
        ScrollView {
            Text("\(note?.content ?? "")")

        }.onChange(of: date) {
            print(habit.notes)
            note = habit.getNotesByDate(date).first
        }
    }
}

//
// #Preview {
//    HNotePerDayView()
// }
