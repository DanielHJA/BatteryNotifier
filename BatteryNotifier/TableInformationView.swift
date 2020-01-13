//
//  TableInformationView.swift
//  BatteryNotifier
//
//  Created by Daniel Hjärtström on 2019-11-29.
//  Copyright © 2019 Daniel Hjärtström. All rights reserved.
//

import Cocoa

class TableInformationView: NSView {
    
    private var keyCells = [String]()
    private var valueCells = [String]()
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(batteryInfoUpdated), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    func configureTableView() {
        tableView = NSTableView()
        tableView.rowSizeStyle = .large
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.selectionHighlightStyle = .none
        tableView.dataSource = self
        tableView.addTableColumn(keyColumn)
        tableView.addTableColumn(valueColumn)
    }
    
    @objc private func batteryInfoUpdated(_ notification: Notification) {
        if let object = notification.object as? BatteryInfo {
            
            if keyCells.isEmpty {
                let batteryHealthKeyCell = "Battery health"
                let currentKeyCell = "Current"
                let currentCapacityKeyCell = "Battery percentage"
                let isChargingKeyCell = "Is currently charging"
                let maxCapacityKeyCell = "Max battery capacity percentage"
                let timeToEmptyKeyCell = "Minutes till empty"
                let timeToFullChargeKeyCell = "Minutes to full charge"
                keyCells = [batteryHealthKeyCell, currentKeyCell, currentCapacityKeyCell, isChargingKeyCell, maxCapacityKeyCell, timeToEmptyKeyCell, timeToFullChargeKeyCell]
            }
            
            let batteryHealthKeyCell = object.batteryViewModel.batteryHealth
            let currentKeyCell = object.batteryViewModel.current
            let currentCapacityKeyCell = object.batteryViewModel.currentCapacity
            let isChargingKeyCell = object.batteryViewModel.isCharging
            let maxCapacityKeyCell = object.batteryViewModel.maxCapacity
            let timeToEmptyKeyCell = object.batteryViewModel.timeToEmpty
            let timeToFullChargeKeyCell = object.batteryViewModel.timeToFullCharge
            valueCells = [batteryHealthKeyCell, currentKeyCell, currentCapacityKeyCell, isChargingKeyCell, maxCapacityKeyCell, timeToEmptyKeyCell, timeToFullChargeKeyCell]
            tableView.reloadData()
            Status.shared.checkIfCriticalLevelWithInfo(object)
        }
    }
    
}

extension TableInformationView: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return keyCells.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if tableColumn?.identifier.rawValue == "key" {
            let name = keyCells[row]
            return CenteredTextfieldView(string: name, isBold: true, size: 18.0)
        }
        
        if tableColumn?.identifier.rawValue == "value" {
            let name = valueCells[row]
            return CenteredTextfieldView(string: name, isBold: false, size: 16.0)
        }

        return NSView()
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 50.0
    }
            
}
