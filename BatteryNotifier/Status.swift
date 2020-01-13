//
//  Status.swift
//  BatteryNotifier
//
//  Created by Daniel Hjärtström on 2019-12-05.
//  Copyright © 2019 Daniel Hjärtström. All rights reserved.
//

import Cocoa

class Status {
    static let shared = Status()
    
    var didRespondToNotification: Bool = false
    var notificationIsActive = false
    private var player = SoundPlayer()

    func checkIfCriticalLevelWithInfo(_ info: BatteryInfo) {
        if !didRespondToNotification {
            
            if !notificationIsActive {
                if let value = UserDefaults.standard.value(forKey: "critialBatteryLevel") as? Int32 {
                    if info.currentCapacity <= value {
                        LocalNotification.scheduleNotification()
                        notificationIsActive = true
                    }
                }
            }
            
            if let path = UserDefaults.standard.value(forKey: "notificationSound") as? String {
                if let criticalBatteryLevel = UserDefaults.standard.value(forKey: "critialBatteryLevel") as? Int32 {
                    if let url = URL(string: path) {
                        if info.currentCapacity <= criticalBatteryLevel {
                            player.playSound(url: url)
                        }
                    }
                }
            }
        }
        
        checkIfbatteryLevelIsAboveCriticalLevel(info)
    }
    
    private func checkIfbatteryLevelIsAboveCriticalLevel(_ info: BatteryInfo) {
        if didRespondToNotification {
            if let value = UserDefaults.standard.value(forKey: "critialBatteryLevel") as? Int32 {
                if info.currentCapacity > value {
                    didRespondToNotification = false
                }
            }
        }
    }
    
}
