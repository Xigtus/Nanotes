//
//  SwiftUIView.swift
//  Notes Demo (iOSConfSG)
//
//  Created by Alifiyah Ariandri on 11/07/24.
//

import SwiftUI

struct HabitRowView: View {
    var habit: Habit

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(habit.title.isEmpty ? "New Habit" : habit.title)
                    .font(.headline)
                    .lineLimit(1)
                Text(habit.startDate, format: Date.FormatStyle()
                    .day(.twoDigits)
                    .month(.twoDigits)
                    .year(.twoDigits))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}
