//
//  Infoswift
//  BatteryNotifier
//
//  Created by Daniel Hjärtström on 2019-11-29.
//  Copyright © 2019 Daniel Hjärtström. All rights reserved.
//

import Cocoa

class InfoView: NSView {
    
    private lazy var topView: BatteryView = {
        let temp = BatteryView()
        temp.wantsLayer = true
        temp.layer?.backgroundColor = Constants.Colors.black.cgColor
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        return temp
    }()
    
    private lazy var bottomView: TableInformationView = {
        let temp = TableInformationView()
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        temp.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
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
        bottomView.isHidden = false
        topView.isHidden = false
    }
    
}
