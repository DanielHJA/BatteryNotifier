//
//  SliderView.swift
//  BatteryNotifier
//
//  Created by Daniel Hjärtström on 2019-12-02.
//  Copyright © 2019 Daniel Hjärtström. All rights reserved.
//

import Cocoa

class EditableTextFieldView: NSView, NSTextFieldDelegate {
    
    private lazy var label: NSTextField = {
        let temp = NSTextField()
        temp.backgroundColor = .clear
        temp.isBezeled = false
        temp.isEditable = true
        temp.delegate = self
        temp.isBordered = true
        temp.font = NSFont.boldSystemFont(ofSize: 16.0)
        temp.sizeToFit()
        temp.alignment = .left
        temp.textColor = .white
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
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
    
    convenience init() {
        self.init(frame: .zero)
        commonInit()
    }

    func commonInit() {
        label.isHidden = false
    }
    
}
