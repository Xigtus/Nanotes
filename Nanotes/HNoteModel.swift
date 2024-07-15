//
//  NoteModel.swift
//  Nanotes
//
//  Created by Alifiyah Ariandri on 15/07/24.
//

import Foundation
import SwiftData

@Model
final class HNoteModel {
    var uuid: UUID
    var lastModified: Date
    var content: String

    @Attribute(.unique)
    var habit: HabitModel

    var date: Date

    init(lastModified: Date, habit: HabitModel, date: Date, content: String = "") {
        self.uuid = UUID()
        self.lastModified = lastModified
        self.habit = habit
        self.date = date
        self.content = content
    }

    func updateLastModified(lastModified: Date) {
        self.lastModified = lastModified
    }
}
