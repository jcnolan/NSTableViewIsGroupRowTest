//
//  TermsTextView.swift
//  WKID
//
//  Created by Beckertalk67 on 3/27/18.
//  Copyright © 2018 Warnock-Becker. All rights reserved.
//

import Cocoa

class TermTextView: NSTextView {
// -no    class TermTextView: NSTextField {

    weak var parent: CMTViewController!
 //   weak var termsNuController: DensSeeNuViewController!

    var row: Int!

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        if let termsController = parent {
            if let term = termsController.clickSubPhrase(in: self, event: event, row: row) {
                termsController.console.stringValue = "\"\(term)\" clicked..."
            }
        }
    }
}
