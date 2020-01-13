//
//  SoundPickerView.swift
//  BatteryNotifier
//
//  Created by Daniel Hjärtström on 2019-12-04.
//  Copyright © 2019 Daniel Hjärtström. All rights reserved.
//

import Cocoa

class SoundPickerView: NSView, NSComboBoxDataSource, NSComboBoxDelegate {
    
    var items = [URL]() {
        didSet {
            comboBox.reloadData()
        }
    }
    
    private lazy var comboBox: NSComboBox = {
        let temp = NSComboBox()
        temp.usesDataSource = true
        temp.dataSource = self
        temp.delegate = self
        temp.isEditable = false
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
        temp.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
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
        loadSoundFiles()
        loadSelectedSoundIfExist()
        NotificationCenter.default.addObserver(self, selector: #selector(newFileAdded), name: NSNotification.Name(rawValue: "newFile"), object: nil)
    }
    
    func loadSelectedSoundIfExist() {
        if let selectedSound = UserDefaults.standard.value(forKey: "notificationSound") as? String {
            guard let url = URL(string: selectedSound) else { return }
            let components = items.map { $0.lastPathComponent }
            let index = components.firstIndex(of: url.lastPathComponent) ?? 0
            comboBox.selectItem(at: index)
        }
    }
    
    @objc func newFileAdded() {
        loadSoundFiles()
    }
    
    func loadSoundFiles() {
        Filehandler.listSoundItemsAtPath { (urls) in
            self.items = urls
        }
    }
    
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        return items.count
    }
    
    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        return items[index].lastPathComponent
    }

    func comboBoxSelectionDidChange(_ notification: Notification) {
        let index = comboBox.indexOfSelectedItem
        UserDefaults.standard.setValue("\(items[index])", forKey: "notificationSound")
    }
    
}
