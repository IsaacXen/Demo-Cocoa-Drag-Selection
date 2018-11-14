//
//  NSView+ViewsInFrame.swift
//  ViewsInFrame
//
//  Created by Isaac Chen on 2018/11/14.
//  Copyright © 2018 ix4n33. All rights reserved.
//

import Cocoa

extension NSView {
    
    enum CaptureOption {
        case any, midPoint, full
    }
    
    func views(in frameRect: NSRect, options: CaptureOption = .midPoint) -> [NSView] {
        return subviews.filter { view in
            switch options {
            case .any:
                return frameRect.intersects(view.frame)
            case .midPoint:
                return frameRect.contains(NSMakePoint(view.frame.midX, view.frame.midY))
            case .full:
                return frameRect.contains(view.frame)
            }
        }
    }
    
    func contain(_ view: NSView, in frameRect: NSRect, options: CaptureOption = .midPoint) -> Bool {
        switch options {
        case .any:
            return frameRect.intersects(view.frame)
        case .midPoint:
            return frameRect.contains(NSMakePoint(view.frame.midX, view.frame.midY))
        case .full:
            return frameRect.contains(view.frame)
        }
    }
}
