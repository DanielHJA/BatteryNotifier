//
//  BatteryManager.swift
//  BatteryNotifier
//
//  Created by Daniel Hjärtström on 2019-11-29.
//  Copyright © 2019 Daniel Hjärtström. All rights reserved.
//

import Cocoa

class BatteryManager: NSObject {

    class func getBatteryInfo(completion: @escaping (BatteryInfo) -> ()) {
        let blob = IOPSCopyPowerSourcesInfo()
        if let list = IOPSCopyPowerSourcesList(blob?.takeRetainedValue()) {
            let array = list.takeRetainedValue().asNSArray()
            if let data = array.asData() {
                if let info: BatteryInfo = data.decode() {
                    completion(info)
                }
            }
        }
    }
}

extension NSArray {
    func asData() -> Data? {
        do {
            if let object = self.firstObject {
                let data = try JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions.fragmentsAllowed)
                 return data
            }
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
        return nil
    }
}

extension CFArray {
    func asNSArray() -> NSArray {
        return self as NSArray
    }
}

extension Data {
    func decode<T: Decodable>() -> T? {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(T.self, from: self)
            return result
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}
