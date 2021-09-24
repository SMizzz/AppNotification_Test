//
//  ViewController.swift
//  AppNotification_Test
//
//  Created by 신미지 on 2021/09/24.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
  
  let userNotificationCenter = UNUserNotificationCenter.current()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userNotificationCenter.delegate = self
    
    requestNotificationAuthorization()
    sendNotification(seconds: 10)
  }
  
  func requestNotificationAuthorization() {
    let authOptions = UNAuthorizationOptions(
      arrayLiteral: .alert, .badge, .sound)
    
    userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
      if let error = error {
        print("Error: \(error)")
      }
    }
  }
  
  func sendNotification(seconds: Double) {
    let notificationContent = UNMutableNotificationContent()
    
    notificationContent.title = "알림 테스트"
    notificationContent.body = "이것은 알림을 테스트 하는 것이다"
    
    let trigger = UNTimeIntervalNotificationTrigger(
      timeInterval: seconds,
      repeats: false)
    
    let request = UNNotificationRequest(
      identifier: "testNotification",
      content: notificationContent,
      trigger: trigger)
    
    userNotificationCenter.add(request) { error in
      if let error = error {
        print("Notification Error: ", error)
      }
    }
  }
  
}

extension ViewController: UNUserNotificationCenterDelegate {
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    completionHandler()
  }
  
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      completionHandler([.alert, .badge, .sound])
    }
}
