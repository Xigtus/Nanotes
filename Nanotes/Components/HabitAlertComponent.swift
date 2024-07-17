//
//  HabitAlertComponent.swift
//  Nanotes
//
//  Created by Doni Pebruwantoro on 15/07/24.
//

import SwiftUI
import UserNotifications

struct HabitAlertComponent: View {
//    @Binding var habitAlert: String
    @Binding var data: HabitModel
    private let alertHelper = AlertHelper.shared
    
    var body: some View {
        Section {
            Picker("Alert", selection: $data.habitAlert) {
                ForEach(notificationAlert, id: \.self) { alert in
                    Text(alert).tag(alert)
                }
            }
        }
        .onReceive(data.habitAlert.publisher) { _ in
            scheduleNotification(habitName: $data.habitName.wrappedValue, time: $data.habitTime.wrappedValue, alert: $data.habitAlert.wrappedValue)
        }

    }
    
    private func scheduleNotification(habitName: String, time:Date, alert: String) {
        let intervalNotif = alertHelper.setReminderIntervalTime(habitTime: time, alert: alert)
        
        if intervalNotif > 0 {
            // Create notification content
            let content = UNMutableNotificationContent()
            content.title = "Habit Reminder"
            content.body = "Don't forget to practice your habit: \(habitName)"
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: intervalNotif, repeats: false)
            
            // Create a unique identifier for the notification
            let identifier = UUID().uuidString
            
            // Create the notification request
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            // Add the notification request to the notification center
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Failed to schedule notification: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled successfully")
                }
            }
        }
        
    }
}
