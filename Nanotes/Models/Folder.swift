//
//  Folder.swift
//  Nanotes
//
//  Created by Alifiyah Ariandri on 11/07/24.
//

import Foundation
import SwiftData

@Model
final class Folder {
    var uuid: UUID
    var lastModified: Date
    @Attribute(.unique)
    var folderName: String

    @Relationship(deleteRule: .cascade, inverse: \Habit.folder) var habits: [Habit]

    init(lastModified: Date, folderName: String) {
        self.uuid = UUID()
        self.lastModified = lastModified
        self.folderName = folderName
        self.habits = []
    }

    func updateLastModified(lastModified: Date) {
        self.lastModified = lastModified
    }
}
