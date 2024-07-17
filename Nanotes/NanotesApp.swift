//
//  NanotesApp.swift
//  Nanotes
//
//  Created by Gusti Rizky Fajar on 10/07/24.
//

import SwiftUI

@main
struct NanotesApp: App {
    @StateObject private var habitService = SwiftDataHabitService()
    
    var body: some Scene {
        WindowGroup {
            HabitView()
                .environmentObject(habitService)
        }
    }
}
