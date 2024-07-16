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

    @Environment(\.modelContext) private var modelContext

    @State private var note: HNoteModel?

    var body: some View {
        ScrollView {
            if let note = note {
                TextEditor(text: Binding(
                    get: { note.content },
                    set: { note.content = $0 }
                ))
                .padding()
            } else {
                Text("No note available for this date")
                    .padding()
            }
        }
        .onChange(of: date) { newDate in
            print(habit.notes)
            note = habit.getNotesByDate(newDate).first
        }
    }

    func createNewNote() {
        let newNote = HNoteModel(lastModified: Date(), habit: habit, date: date, content: "New Note")
        modelContext.insert(newNote)
        self.note = newNote
    }

    init(habit: HabitModel, date: Date) {
        self.habit = habit
        self.date = date
        _note = State(initialValue: habit.getNotesByDate(date).first)
    }
}

//
// #Preview {
//    HNotePerDayView()
// }
