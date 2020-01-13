//
//  CellView.swift
//  BatteryNotifier
//
//  Created by Daniel Hjärtström on 2019-11-29.
//  Copyright © 2019 Daniel Hjärtström. All rights reserved.
//

import Cocoa

class CellView: NSView {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        wantsLayer = true
        layer?.backgroundColor = NSColor.red.cgColor
    }
    
}
