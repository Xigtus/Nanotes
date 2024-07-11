//
//  NotesView.swift
//  Notes Demo (iOSConfSG)
//
//  Created by Don Chia on 7/8/23.
//

import SwiftData
import SwiftUI

struct NotesView: View {
    var folder: Folder

    @Environment(\.modelContext) private var modelContext

    var body: some View {
        List {
            ForEach(folder.habits) { habit in
                NavigationLink(destination: EditHabitView(habit: habit), label: {
                    HabitRowView(habit: habit)
                })
                .swipeActions(allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        modelContext.delete(habit)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }


        }
        .navigationTitle(Text(folder.folderName))
        .toolbar {
            ToolbarItem(placement: .bottomBar, content: {
                HStack {
                    Button(action: createNote) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundStyle(.blue)
                            Text("New Note")
                                .font(.system(.body, design: .rounded).bold())
                                .foregroundColor(.blue)
                        }
                    }
                    Spacer()
                }
                .buttonStyle(.plain)
            })
        }
    }

    private func createNote() {
        withAnimation {

            let newHabit = Habit(folder: folder)
            folder.habits.append(newHabit)
            folder.updateLastModified(lastModified: Date())
        }
    }
}

// #Preview {
//    NotesFolderView()
// }
