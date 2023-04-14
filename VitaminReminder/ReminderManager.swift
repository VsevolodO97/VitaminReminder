import Foundation
import UserNotifications

class ReminderManager {
    static let shared = ReminderManager()

    private init() {}

    func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notification authorization: \(error)")
            }
        }
    }

    func scheduleReminder(reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = "Vitamin Reminder"
        content.body = "It's time to take \(reminder.vitamin.name)!"
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: reminder.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)

        let request = UNNotificationRequest(identifier: reminder.vitamin.name, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled successfully for reminder with vitamin name: \(reminder.vitamin.name)")
            }
        }
    }

    func cancelReminder(for name: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [name])
    }
}
