//
//  AddHabitView.swift
//  Nanotes
//
//  Created by Gusti Rizky Fajar on 11/07/24.
//

import SwiftUI
import SwiftData

struct AddHabitView: View {
	
	@Environment(\.dismiss) var dismiss
	@Environment(\.modelContext) var modelContext
	
	@State private var habitDetails = HabitModel()
//	private var endDate: Date! = nil
	
	let repeatFrequency = ["Every Day", "Every Week"]
	let notificationAlert = ["None", "At time of event", "5 minutes before", "10 minutes before"]
	
    var body: some View {
		List {
			Section {
				HStack {
					Text("Habit")
						.padding(.trailing, 20)
					TextField("Habit name", text: $habitDetails.habitName)
				}
			}
			
			Section {
				DatePicker("Start Date", selection: $habitDetails.habitStartDate, displayedComponents: .date)
				DatePicker("End Date", selection: $habitDetails.habitEndDate, displayedComponents: .date)
			}
			
			Section("Repeat Option") {
				Picker("Repeat", selection: $habitDetails.habitRepeat) {
					ForEach(repeatFrequency, id: \.self) { habit in
						Text(habit).tag(habit)
					}
				}
				
				DatePicker("Time", selection: $habitDetails.habitTime, displayedComponents: .hourAndMinute)
			}
			
			Section {
				Picker("Alert", selection: $habitDetails.habitAlert) {
					ForEach(notificationAlert, id: \.self) { alert in
						Text(alert).tag(alert)
					}
				}
			}
		}
		.navigationTitle("New Habit")
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button("Save") {
					withAnimation {
						modelContext.insert(habitDetails)
					}
					dismiss()
				}
			}
			
			ToolbarItem(placement: .cancellationAction) {
				Button("Cancel") {
					dismiss()
				}
			}
		}
    }
}

#Preview {
    AddHabitView()
}
