//
//  TextViewTableCellView.swift
//  WKID
//
//  Created by Beckertalk67 on 3/26/18.
//  Copyright © 2018 Warnock-Becker. All rights reserved.
//

import Cocoa

class TextViewTableCellView: NSTableCellView {

    @IBOutlet var textView: TermTextView!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
}
