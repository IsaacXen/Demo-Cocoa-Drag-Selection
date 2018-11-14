//
//  RandomView.swift
//  ViewsInFrame
//
//  Created by Isaac Chen on 2018/11/14.
//  Copyright © 2018 ix4n33. All rights reserved.
//

import Cocoa

@IBDesignable
class RandomView: NSView {
    
    var selected = false {
        didSet { needsDisplay = true }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        let path = NSBezierPath(roundedRect: dirtyRect, xRadius: 0, yRadius: 0)
        path.lineWidth = 2
        if selected {
            NSColor.selectedContentBackgroundColor.setStroke()
            NSColor.selectedContentBackgroundColor.withAlphaComponent(0.2).setFill()
        } else {
            NSColor.tertiaryLabelColor.setStroke()
            NSColor.quaternaryLabelColor.setFill()
        }
        path.fill()
        path.stroke()
    }
    
}
