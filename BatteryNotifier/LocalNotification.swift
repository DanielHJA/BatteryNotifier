//
//  LocalNotification.swift
//  BatteryNotifier
//
//  Created by Daniel Hjärtström on 2019-12-03.
//  Copyright © 2019 Daniel Hjärtström. All rights reserved.
//

import Cocoa
import UserNotifications

class LocalNotification: NSObject {
    
    class func scheduleNotification() {
        let notification = NSUserNotification()
        notification.identifier = UUID().uuidString
        notification.deliveryDate = Date(timeIntervalSinceNow: 5.0)
        notification.title = "Warning"
        notification.subtitle = "The battery level has reached your set critical level."
        notification.informativeText = "Please connect your computer to a power outlet."
        notification.hasActionButton = true
        notification.actionButtonTitle = "Thanks!"
        notification.contentImage = NSImage(named: "battery")
        let notificationCenter = NSUserNotificationCenter.default
        notificationCenter.deliver(notification)
    }

}

