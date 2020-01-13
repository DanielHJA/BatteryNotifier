//
//  ViewController.swift
//  BatteryNotifier
//
//  Created by Daniel Hjärtström on 2019-11-29.
//  Copyright © 2019 Daniel Hjärtström. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    private lazy var topBar: NSView = {
        let temp = NSView()
        temp.wantsLayer = true
        temp.layer?.backgroundColor = NSColor.blue.cgColor
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        return temp
    }()

    private lazy var infoView: InfoView = {
        let temp = InfoView()
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        temp.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        return temp
    }()
    
    private lazy var settingsView: SettingsView = {
        let temp = SettingsView()
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        temp.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        return temp
    }()
    
    private lazy var label: NSTextField = {
        let temp = NSTextField()
        temp.backgroundColor = .clear
        temp.isBezeled = false
        temp.isEditable = false
        temp.font = NSFont.boldSystemFont(ofSize: 28.0)
        temp.sizeToFit()
        temp.textColor = .white
        temp.stringValue = "Battery Monitor"
        topBar.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerXAnchor.constraint(equalTo: topBar.centerXAnchor).isActive = true
        temp.centerYAnchor.constraint(equalTo: topBar.centerYAnchor).isActive = true
        return temp
    }()
    
    private var timer: Timer!
    private var timeInterval: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTimer()
        label.isHidden = false
        infoView.isHidden = false
        settingsView.isHidden = false
        getBatteryInfo()
    }
    
    private func configureTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true, block: { (timer) in
            self.getBatteryInfo()
        })
    }

    private func getBatteryInfo() {
        BatteryManager.getBatteryInfo { (info) in
            self.postNotificationWithInfo(info)
        }
    }
        
    private func postNotificationWithInfo(_ info: BatteryInfo) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newData"), object: info)
    }
    
    private func configureView() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
    }

}

