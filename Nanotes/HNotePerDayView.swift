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
        ScrollView {
            if let note = note {
                if let imageData = note.selectedPhotoData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(height: 200)
                }

                PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
                    Label("Add Image", systemImage: "photo")
                }
                
                if note.selectedPhotoData != nil {
                    Button(role: .destructive) {
                        withAnimation {
                            selectedPhoto = nil
                            note.selectedPhotoData = nil
                        }
                    } label: {
                        Label("Remove Image", systemImage: "xmark")
                            .foregroundColor(.red)
                    }
                }

                TextEditor(text: Binding(
                    get: { note.content },
                    set: { note.content = $0 }
                ))
                .padding()
            } else {
                Text("You haven't done this habit this day")
                    .padding()
                    .foregroundColor(.gray)
            }
        }
        .onChange(of: date) { newDate in
            print(self.habit.notes)
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
