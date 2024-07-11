//
//  Habit.swift
//  Notes Demo (iOSConfSG)
//
//  Created by Alifiyah Ariandri on 11/07/24.
//

import Foundation
import SwiftData

@Model
final class Habit {
    var uuid: UUID
    var title: String
    var desc: String
    var startDate: Date
    var endDate: Date
    var folder: Folder?

    init(folder: Folder) {
        self.uuid = UUID()
        self.title = ""
        self.desc = ""
        self.startDate = Date()
        self.endDate = Date()
        self.folder = folder
    }
}
