//
//  FileSelectionView.swift
//  BatteryNotifier
//
//  Created by Daniel Hjärtström on 2019-12-03.
//  Copyright © 2019 Daniel Hjärtström. All rights reserved.
//

import Cocoa

class FileSelectionView: NSView, NSTextFieldDelegate {
    
    private var lastPath: URL?
    
    private lazy var label: NSTextField = {
        let temp = NSTextField()
        temp.backgroundColor = .white
        temp.isBezeled = false
        temp.isEditable = false
        temp.delegate = self
        temp.isBordered = true
        temp.sizeToFit()
        temp.alignment = .left
        temp.textColor = .black
        temp.maximumNumberOfLines = 1
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -20.0).isActive = true
        temp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        temp.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        return temp
    }()
    
    private lazy var button: NSButton = {
        let temp = NSButton()
        let title = "Select"
        let myAttribute = [ NSAttributedString.Key.foregroundColor: NSColor.white ]
        let myAttrString = NSAttributedString(string: title, attributes: myAttribute)
        temp.attributedTitle = myAttrString
        temp.bezelStyle = .texturedSquare
        temp.isBordered = false
        temp.wantsLayer = true
        temp.layer?.backgroundColor = NSColor.blue.cgColor
        temp.layer?.cornerRadius = 5.0
        temp.action = #selector(didClickSelectFile)
        temp.target = self
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        temp.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        return temp
    }()
    
    private lazy var saveButton: NSButton = {
        let temp = NSButton()
        let title = "Save file"
        let myAttribute = [ NSAttributedString.Key.foregroundColor: NSColor.white ]
        let myAttrString = NSAttributedString(string: title, attributes: myAttribute)
        temp.attributedTitle = myAttrString
        temp.bezelStyle = .texturedSquare
        temp.isBordered = false
        temp.wantsLayer = true
        temp.layer?.backgroundColor = NSColor.blue.cgColor
        temp.layer?.cornerRadius = 5.0
        temp.action = #selector(didClickSaveFile)
        temp.target = self
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        temp.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        temp.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 10.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
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
        label.isHidden = false
        button.isHidden = false
        saveButton.isHidden = false
        wantsLayer = true
        layer?.backgroundColor = Constants.Colors.white.cgColor
    }
    
    @objc func didClickSaveFile() {
        if let path = lastPath {
            Filehandler.saveObjectAtPath(path)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "newFile"), object: nil)
        }
    }
    
    @objc func didClickSelectFile() {
        let dialog = NSOpenPanel()
        
        dialog.title = "Choose an audio file"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseDirectories = false
        dialog.canCreateDirectories = false
        dialog.allowsMultipleSelection = false
        dialog.allowedFileTypes = ["wav", "mp3", "m4a"]
        
        if dialog.runModal() == .OK {
            let result = dialog.url
            
            if result != nil {
                if let path = result?.path {
                    let components = path.components(separatedBy: "/").last!
                    label.stringValue = components
                    lastPath = result
                }
            } else {
                print("User cancelled")
                return
            }
        }
    }
    
}
