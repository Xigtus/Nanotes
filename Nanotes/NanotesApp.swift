//
//  NanotesApp.swift
//  Nanotes
//
//  Created by Gusti Rizky Fajar on 10/07/24.
//

import SwiftUI

@main
struct NanotesApp: App {
    var body: some Scene {
        WindowGroup {
            HabitView()
				.modelContainer(for: HabitModel.self)
        }
    }
}
