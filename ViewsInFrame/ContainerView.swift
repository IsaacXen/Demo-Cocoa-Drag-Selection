//
//  ContainerView.swift
//  ViewsInFrame
//
//  Created by Isaac Chen on 2018/11/14.
//  Copyright © 2018 ix4n33. All rights reserved.
//

import Cocoa

class ContainerView: NSView {
    
    var selectionMode: CaptureOption = .midPoint
    
    override func draw(_ dirtyRect: NSRect) {
        let path = NSBezierPath(rect: dirtyRect)
        path.lineWidth = 1
        NSColor.quaternaryLabelColor.setFill()
        NSColor.tertiaryLabelColor.setStroke()
        path.fill()
        path.stroke()
        
        super.draw(dirtyRect)

        if let rect = selectionRect {
            let path = NSBezierPath(rect: rect)
            NSColor.selectedContentBackgroundColor.withAlphaComponent(0.2).setFill()
            NSColor.selectedContentBackgroundColor.setStroke()
            path.lineWidth = 1
            path.fill()
            path.stroke()
        }
    }
    
    override func viewDidMoveToWindow() {
        let trackingArea = NSTrackingArea(rect: frame, options: [.activeInActiveApp, .mouseMoved], owner: self, userInfo: nil)
        addTrackingArea(trackingArea)
    }
    
    private var isMouseDown = false
    private var downPoint: CGPoint?
    private var selectionRect: NSRect? = .zero {
        didSet {
            subviews.forEach { view in
                if let view = view as? RandomView {
                    if let rect = selectionRect {
                        view.selected = contain(view, in: rect, options: selectionMode)
                    } else {
                        view.selected = false
                    }
                }
            }
            
            needsDisplay = true
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        downPoint = convert(event.locationInWindow, from: nil)
    }
    
    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        let currentPoint = convert(event.locationInWindow, from: nil)
        selectionRect = frame.rect(from: downPoint!, to: currentPoint)
    }
    
    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        selectionRect = nil
        downPoint = nil
    }
    
}

extension NSRect {
    func rect(from point1: CGPoint, to point2: CGPoint) -> NSRect {
        let x = max(min(point1.x, point2.x), 0)
        let y = max(min(point1.y, point2.y), 0)
        let w = abs(min(max(0, point1.x), width) - min(max(0, point2.x), width))
        let h = abs(min(max(0, point1.y), height) - min(max(0, point2.y), height))
        return NSMakeRect(x, y, w, h)
    }
}
