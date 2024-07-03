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
    @Binding var habit: HabitModel

    func makeCoordinator() -> Coordinator {
        Coordinator(self, habit: habit)
    }

    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
//        calendar.appearance.selectionColor = .systemPurple
        // Remove today circle
//        calendar.today = nil
        calendar.appearance.headerTitleColor = .gray
        calendar.appearance.weekdayTextColor = .gray

        return calendar
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) {
        // update the calendar view if necessary
    }

    // MARK: - Coordinator

    class Coordinator: NSObject, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
        var parent: FSCalendarView

        var habit: HabitModel

        var dates: [Date]
        var datesWithImage: [Date: Data]

        init(_ calender: FSCalendarView, habit: HabitModel) {
            self.parent = calender
            self.habit = habit
            self.dates = habit.getCompletionDates()
            self.datesWithImage = habit.getDatesWithImage()
        }

        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
        }

        // Disable dates after today
        func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
            return date <= Date()
        }

        // Change title color for future dates to grey
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
            return date > Date() ? .lightGray : nil
        }

        // Utility function to resize, crop to a circle, and set opacity of the image
        func processImage(image: UIImage, targetSize: CGSize, opacity: CGFloat) -> UIImage? {
            // Resize the image
            let size = image.size
            let widthRatio = targetSize.width / size.width
            let heightRatio = targetSize.height / size.height
            let scaleFactor = min(widthRatio, heightRatio)
            let scaledSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)

            // Begin a new image context
            UIGraphicsBeginImageContextWithOptions(scaledSize, false, 0.0)
            guard let context = UIGraphicsGetCurrentContext() else { return nil }

            // Set the opacity
            context.setAlpha(opacity)

            // Create a circular path
            let circlePath = UIBezierPath(ovalIn: CGRect(origin: .zero, size: scaledSize))
            circlePath.addClip()

            // Draw the image within the circular path
            image.draw(in: CGRect(origin: .zero, size: scaledSize))

            // Get the processed image
            let processedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return processedImage
        }

        func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
            let targetSize = CGSize(width: 30, height: 30) // Set your desired size here
            let opacity: CGFloat = 0.3 // 30% opacity

            if let imageData = datesWithImage.first(where: { Calendar.current.isDate($0.key, inSameDayAs: date) })?.value,
               let image = UIImage(data: imageData)
            {
                return processImage(image: image, targetSize: targetSize, opacity: opacity)
            }
            if dates.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
                if let image = UIImage(named: "Ellipse") {
                    return processImage(image: image, targetSize: targetSize, opacity: opacity)
                }
            }
            return nil
        }

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
