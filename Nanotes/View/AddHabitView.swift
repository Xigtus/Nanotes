//
//  AddHabitView.swift
//  Nanotes
//
//  Created by Gusti Rizky Fajar on 11/07/24.
//

import SwiftUI

struct AddHabitView: View {
	
	@Environment(\.dismiss) var dismiss
	@Environment(\.modelContext) var modelContext
	
	@State private var habitDetails = HabitModel()
//	private var endDate: Date! = nil
		
    var body: some View {
        CreateHabitViewModel(data: $habitDetails)
    }
}
