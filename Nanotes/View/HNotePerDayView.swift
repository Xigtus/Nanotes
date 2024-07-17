
//
//  HNotePerDayView.swift
//  Nanotes
//
//  Created by Alifiyah Ariandri on 15/07/24.
//

import PhotosUI
import SwiftUI

struct HNotePerDayView: View {
    var habit: HabitModel
    var date: Date

    @State var selectedPhoto: PhotosPickerItem?

    @State private var note: HNoteModel?

    var body: some View {
        VStack {
            if habit.habitIsCompleted {
                if let note = note {
                    TextField("Add a note", text: Binding(
                        get: { note.content },
                        set: { newContent in
                            note.content = newContent
                        }
                    ))
                    .font(.callout)

                    VStack {
                        if let imageData = note.selectedPhotoData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(height: 200)
                        }

                        PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
                            Label("Attach Image", systemImage: "photo")
                        }

                        if note.selectedPhotoData != nil {
                            Button(role: .destructive) {
                                withAnimation {
                                    selectedPhoto = nil
                                    note.selectedPhotoData = nil
                                }
                            } label: {
                                Label("Remove Image", systemImage: "xmark")
                                    .foregroundStyle(Color.pink)
                            }
                        }
                    }
                    .padding(.top)
                } else {
                    Text("No note found for this habit on this day")
                        .foregroundColor(.gray)
                }
            } else {
                Text("You haven't done this habit on this day")
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        .padding(.horizontal)
        .onChange(of: date) { newDate in
            self.note = self.habit.getNotesByDate(newDate).first
        }
        .onAppear {
            self.note = self.habit.getNotesByDate(self.date).first
        }
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                note?.selectedPhotoData = data
            }
        }
    }
}

//
// #Preview {
//    HNotePerDayView()
// }
