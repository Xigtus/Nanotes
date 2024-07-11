//
//  EditHabitView.swift
//  Notes Demo (iOSConfSG)
//
//  Created by Alifiyah Ariandri on 11/07/24.
//

import SwiftData
import SwiftUI

struct EditHabitView: View {
    @Bindable var habit: Habit

    @Environment(\.dismiss) var dismiss

    @FocusState var keyboardInputState: Bool

    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Title")
                        .foregroundColor(.gray)
                    TextField("Enter habit title", text: $habit.title)
                }
            }

            Section {
                HStack {
                    Text("Start Date").foregroundColor(.gray)

                    Spacer()
                    DatePicker("", selection: $habit.startDate, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                }
            }
            
            
        }
        .formStyle(.grouped)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button("Done") {
                    keyboardInputState = false
                    dismiss()
                }
            })
        }

//        TextEditor(text: $note.content)
//            .padding(.horizontal)
//            .navigationBarTitleDisplayMode(.inline)
//            .onChange(of: note.content) {
//                note.lastModified = Date()
//            }
//            .onAppear(perform: {
//                keyboardInputState = true
//            })
//            .focused($keyboardInputState)
//            .toolbar {
//                if keyboardInputState {
//                    ToolbarItem(placement: .topBarTrailing, content: {
//                        Button("Done") {
//                            keyboardInputState = false
//                            dismiss()
//                        }
//                    })
//                }
    }
}

// #Preview {
//    EditHabitView(note: Note(content: "Hello World!", lastModified: Date()))
// }
