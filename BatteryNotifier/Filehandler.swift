//
//  Filehandler.swift
//  BatteryNotifier
//
//  Created by Daniel Hjärtström on 2019-12-03.
//  Copyright © 2019 Daniel Hjärtström. All rights reserved.
//

import Cocoa

class Filehandler: NSObject {
    
    class func listSoundItemsAtPath(completion: @escaping ([URL]) -> ()) {
        let filemanager = FileManager.default
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let soundURL = URL(fileURLWithPath: documentsDirectory).appendingPathComponent("sound")
        
        do {
            let files = try filemanager.contentsOfDirectory(at: soundURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            completion(files)
        } catch let error {
            print(error)
        }
    }
    
    class func saveObjectAtPath(_ path: URL?) {
        guard let path = path else { return }
        
        let filemanager = FileManager.default
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let soundURL = URL(fileURLWithPath: documentsDirectory).appendingPathComponent("sound")
        
        let suggestedFilename = path.lastPathComponent
        let filePath = URL(fileURLWithPath: soundURL.path).appendingPathComponent(suggestedFilename)
        
        if !filemanager.fileExists(atPath: soundURL.path) {
            do {
                try filemanager.createDirectory(at: soundURL, withIntermediateDirectories: false, attributes: [:])
            } catch let error {
                print(error)
            }
        }

        if filemanager.fileExists(atPath: filePath.path) {
            print("File exists")
        } else {
            do {
                try filemanager.copyItem(atPath: path.path, toPath: filePath.path)
            } catch let error {
                print(error)
            }
        }
    }
}
