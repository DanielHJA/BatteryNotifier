//
//  CenteredTextfieldView.swift
//  BatteryNotifier
//
//  Created by Daniel Hjärtström on 2019-12-02.
//  Copyright © 2019 Daniel Hjärtström. All rights reserved.
//

import Cocoa

class CenteredTextfieldView: NSView {
    
    private lazy var label: NSTextField = {
        let temp = NSTextField()
        temp.backgroundColor = .clear
        temp.isBezeled = false
        temp.isEditable = false
        temp.isBordered = false
        temp.maximumNumberOfLines = 1
        temp.backgroundColor = .clear
        temp.usesSingleLineMode = true
        temp.sizeToFit()
        temp.alignment = .left
        temp.textColor = Constants.Colors.white
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
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
    
    convenience init(string: String, isBold: Bool, size: CGFloat) {
        self.init(frame: .zero)
        commonInit()
        label.stringValue = string
        label.font = isBold ? NSFont.boldSystemFont(ofSize: size) : NSFont.systemFont(ofSize: size)
    }

    func commonInit() {
        wantsLayer = true
        layer?.backgroundColor = Constants.Colors.black.cgColor
    }
    
}
