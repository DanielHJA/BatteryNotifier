//
//  SettingsView.swift
//  BatteryNotifier
//
//  Created by Daniel Hjärtström on 2019-11-29.
//  Copyright © 2019 Daniel Hjärtström. All rights reserved.
//

import Cocoa

class SettingsView: NSView {
    
    private var keyCells = [String]()
    private var valueCells = [NSView]()
    
    private lazy var keyColumn: NSTableColumn = {
        let temp = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("key"))
        temp.headerCell.title = "Key"
        temp.headerCell.alignment = .left
        temp.width = 1
        return temp
    }()
    
    private lazy var valueColumn: NSTableColumn = {
        let temp = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("value"))
        temp.headerCell.title = "Value"
        temp.headerCell.alignment = .left
        temp.width = 1
        return temp
    }()
    
    private lazy var scrollViewTableView: NSScrollView = {
        let temp = NSScrollView()
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        return temp
    }()
    
    private var tableView: NSTableView!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    override func resizeSubviews(withOldSize oldSize: NSSize) {
        super.resizeSubviews(withOldSize: oldSize)
        let halfWidth = frame.width / 2
        keyColumn.width = halfWidth
        keyColumn.width = halfWidth
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        addSubview(scrollViewTableView)
        configureTableView()
        scrollViewTableView.documentView = tableView
        configureCells()
    }
    
    func configureTableView() {
        tableView = NSTableView()
        tableView.rowSizeStyle = .large
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.selectionHighlightStyle = .none
        tableView.addTableColumn(keyColumn)
        tableView.addTableColumn(valueColumn)
    }
    
    private func configureCells() {
        let batteryHealthKey = "Minimum Battery Level"
        let soundKey = "Notification sound"
        let soundSelectionKey = "Selected sound"
        keyCells = [batteryHealthKey, soundKey, soundSelectionKey]
        
        let batteryHealthValue = SliderView()
        let sound = FileSelectionView()
        let soundSelection = SoundPickerView()
        valueCells = [batteryHealthValue, sound, soundSelection]
        
        tableView.reloadData()
    }
    
}

extension SettingsView: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return keyCells.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if tableColumn?.identifier.rawValue == "key" {
            let name = keyCells[row]
            return CenteredTextfieldView(string: name, isBold: true, size: 18.0)
        }
        
        if tableColumn?.identifier.rawValue == "value" {
            return valueCells[row]
        }
        
        return NSView()
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 50.0
    }
    
}

