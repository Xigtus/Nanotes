////
////  FSCalendarView.swift
////  Nanotes
////
////  Created by Alifiyah Ariandri on 15/07/24.
////

import FSCalendar
import SwiftUI

struct FSCalendarView: UIViewRepresentable {
    @Binding var selectedDate: Date
//    @Binding var habit: HabitModel

    func makeCoordinator() -> Coordinator {
//        Coordinator(self, habit: habit)
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        calendar.appearance.selectionColor = .systemPurple
        // Remove today circle
//        calendar.today = nil
        calendar.scope = .week
        calendar.appearance.headerTitleColor = .gray
        calendar.appearance.weekdayTextColor = .gray

//        // Calculate the total height needed for the calendar
//        let totalHeight = 100 + calendar.headerHeight + calendar.weekdayHeight
//
//        // Set the static height constraint
//        calendar.translatesAutoresizingMaskIntoConstraints = false
//        calendar.heightAnchor.constraint(equalToConstant: totalHeight).isActive = true
        
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        // update the calendar view if necessary
    }
    
    // MARK: - Coordinator

    class Coordinator: NSObject, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
        var parent: FSCalendarView
        
//        var habit: HabitModel
        
//        var dates: [Date]
        
//        init(_ calender: FSCalendarView, habit: HabitModel) {
        init(_ calender: FSCalendarView) {
            self.parent = calender
//            self.habit = habit
//            self.dates = habit.getCompletionDates()
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
        }
        
//        func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//            if dates.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
//                // Replace "completionImageName" with the actual image name you want to use
//                return UIImage(named: "Ellipse")
//            }
//            return nil
//        }
        
        // Need reload to have fill colors display correctly after calendar page changes
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            calendar.reloadData()
        }
        
        // MARK: - Other

        func isDateInMonth(date: Date, targetMonth: Date) -> Bool {
            return Calendar.current.isDate(date, equalTo: targetMonth, toGranularity: .month)
        }
        
//        func isOnOrAfterAchievementStartDate(date: Date) -> Bool {
//            return date >= achievements.startDate || Calendar.current.isDate(date, equalTo: achievements.startDate, toGranularity: .day)
//        }
    }
}
