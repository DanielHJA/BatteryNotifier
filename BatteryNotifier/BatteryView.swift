//
//  BatteryView.swift
//  BatteryNotifier
//
//  Created by Daniel Hjärtström on 2019-11-29.
//  Copyright © 2019 Daniel Hjärtström. All rights reserved.
//

import Cocoa

class BatteryView: NSView {
    
    private lazy var levelIndicator: NSLevelIndicator = {
        let temp = NSLevelIndicator()
        temp.maxValue = 100
        temp.minValue = 0
        temp.isEditable = false
        temp.criticalFillColor = NSColor.green
        temp.fillColor = NSColor.red
        temp.levelIndicatorStyle = .continuousCapacity
        temp.criticalValue = 5
        temp.numberOfMajorTickMarks = 10
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30.0).isActive = true
        temp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30.0).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        temp.topAnchor.constraint(greaterThanOrEqualTo: label.bottomAnchor, constant: 100).isActive = true
        return temp
    }()
    
    private lazy var label: NSTextField = {
        let temp = NSTextField()
        temp.backgroundColor = .clear
        temp.isBezeled = false
        temp.isEditable = false
        temp.font = NSFont.boldSystemFont(ofSize: 70.0)
        temp.sizeToFit()
        temp.alignment = .center
        temp.textColor = Constants.Colors.white
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        return temp
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        NotificationCenter.default.addObserver(self, selector: #selector(batteryInfoUpdated), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    @objc private func batteryInfoUpdated(_ notification: Notification) {
        if let object = notification.object as? BatteryInfo {
            label.stringValue = object.batteryViewModel.currentCapacity
            levelIndicator.objectValue = object.currentCapacity
        }
    }
    
}
