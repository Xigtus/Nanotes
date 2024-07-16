//
//  HabitAlertComponent.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 15/07/24.
//

import SwiftUI

struct HabitAlertComponent: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @Binding var habitAlert: String
    
    var body: some View {
        Section {
            Picker("Alert", selection: $habitAlert) {
                ForEach(notificationAlert, id: \.self) { alert in
                    Text(alert).tag(alert)
                }
            }
        }

    }
}
