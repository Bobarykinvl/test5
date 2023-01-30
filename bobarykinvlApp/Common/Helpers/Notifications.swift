//
//  Notifications.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 28.01.23.
//

import UIKit
import UserNotifications

final class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()

    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .alert]) { (granted, error) in
            guard granted else { return }
            self.notificationCenter.getNotificationSettings { (settings) in
                guard settings.authorizationStatus == .authorized else { return }
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }

            }
        }
    }
    
    func sendNotifications() {
        let userActionID = "User Action"
        let content = UNMutableNotificationContent()
        content.title = "Hello"
        content.body = "test text"
        content.sound = .defaultCritical
        content.categoryIdentifier = userActionID
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
            print(error?.localizedDescription)
        }
        
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze")
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(identifier: userActionID,
                                              actions: [snoozeAction, deleteAction],
                                              intentIdentifiers: [])
        
        notificationCenter.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "Snooze":
            print("Snooze")
            sendNotifications()
        default:
            print("Unknown action")
        }
    }
}
