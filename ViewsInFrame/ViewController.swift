//
//  ViewController.swift
//  ViewsInFrame
//
//  Created by Isaac Chen on 2018/11/14.
//  Copyright © 2018 ix4n33. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var containerView: ContainerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func didChangeCaptureMode(_ sender: NSButton) {
        if sender.tag == 0 {
            containerView.selectionMode = .midPoint
        } else if sender.tag == 1 {
            containerView.selectionMode = .any
        } else {
            containerView.selectionMode = .full
        }
    }
}

