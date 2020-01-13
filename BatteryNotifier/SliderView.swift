//
//  SliderView.swift
//  BatteryNotifier
//
//  Created by Daniel Hjärtström on 2019-12-03.
//  Copyright © 2019 Daniel Hjärtström. All rights reserved.
//

import Cocoa

class SliderView: NSView {
    
    private lazy var label: NSTextField = {
        let temp = NSTextField()
        temp.backgroundColor = .clear
        temp.isBezeled = false
        temp.isEditable = false
        temp.isBordered = false
        temp.sizeToFit()
        temp.alignment = .center
        temp.textColor = .black
        temp.maximumNumberOfLines = 1
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
        temp.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15).isActive = true
        return temp
    }()
    
    private lazy var slider: NSSlider = {
        let temp = NSSlider(target: self, action: #selector(didSlide))
        temp.maxValue = 100
        temp.minValue = 5
        temp.intValue = 100
        temp.sendAction(on: [.leftMouseUp, .leftMouseDragged])
        temp.sliderType = .linear
        temp.trackFillColor = .green
        temp.trackFillColor = NSColor.blue
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -10.0).isActive = true
        temp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
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
    
    convenience init() {
        self.init(frame: .zero)
        commonInit()
    }

    func commonInit() {
        slider.isHidden = false
        wantsLayer = true
        layer?.backgroundColor = Constants.Colors.white.cgColor
        
        if let value = UserDefaults.standard.value(forKey: "critialBatteryLevel") as? Int32 {
            slider.intValue = value
            label.stringValue = "\(value)"
        }
    }
    
    @objc private func didSlide(_ slider: NSSlider) {
        guard let currentEvent = NSEvent.current else { return }
        
        switch currentEvent {
        case .leftMouseDragged:
            label.stringValue = "\(slider.intValue)"
        case .leftMouseUp:
            UserDefaults.standard.set(slider.intValue, forKey: "critialBatteryLevel")
        default:
            break
        }
        
    }
    
}

extension NSEvent {
    static var current: NSEvent.EventType? {
        return NSApp!.currentEvent?.type
    }
}
