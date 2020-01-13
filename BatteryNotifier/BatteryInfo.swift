//
//  BatteryInfo.swift
//  BatteryNotifier
//
//  Created by Daniel Hjärtström on 2019-11-29.
//  Copyright © 2019 Daniel Hjärtström. All rights reserved.
//

import Foundation

class BatteryInfo: Decodable {
    
    var batteryViewModel: BatteryViewModel!
    let batteryHealth: String
    let current: Int
    let currentCapacity: Int
    let isCharging: Bool
    let maxCapacity: Int
    let timeToEmpty: Int
    let timeToFullCharge: Int
    
    private enum CodingKeys: String, CodingKey {
        case batteryHealth = "BatteryHealth"
        case current = "Current"
        case currentCapacity = "Current Capacity"
        case isCharging = "Is Charging"
        case maxCapacity = "Max Capacity"
        case timeToEmpty = "Time to Empty"
        case timeToFullCharge = "Time to Full Charge"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        batteryHealth = try container.decode(String.self, forKey: .batteryHealth)
        current = try container.decode(Int.self, forKey: .current)
        currentCapacity = try container.decode(Int.self, forKey: .currentCapacity)
        isCharging = try container.decode(Bool.self, forKey: .isCharging)
        maxCapacity = try container.decode(Int.self, forKey: .maxCapacity)
        timeToEmpty = try container.decode(Int.self, forKey: .timeToEmpty)
        timeToFullCharge = try container.decode(Int.self, forKey: .timeToFullCharge)
        batteryViewModel = BatteryViewModel(info: self)
    }
    

}

struct BatteryViewModel {
    
     let batteryHealth: String
     let current: String
     let currentCapacity: String
     let isCharging: String
     let maxCapacity: String
     let timeToEmpty: String
     let timeToFullCharge: String
    
    init(info: BatteryInfo) {
        
        self.batteryHealth = info.batteryHealth
        self.isCharging = "\(info.isCharging)".capitalized
        self.currentCapacity = "\(info.currentCapacity) %"
        self.maxCapacity = ("\(info.maxCapacity) %")

        if info.current < 0 {
            current = "Not applicable"
        } else {
            current = "\(info.current) kW"
        }
        
        if info.timeToFullCharge <= 0 {
            timeToFullCharge = "Not applicable"
          } else {
            timeToFullCharge = "\(info.timeToFullCharge) minutes"
          }
        
        if info.timeToEmpty <= 0 {
            timeToEmpty = "Not applicable"
         } else {
            timeToEmpty = "\(info.timeToEmpty) minutes"
         }
        
    }
    
}
