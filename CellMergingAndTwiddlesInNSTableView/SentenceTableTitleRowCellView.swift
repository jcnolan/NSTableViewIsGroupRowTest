//
//  SentenceTableTitleRowCellView.swift
//  CellMergingAndTwiddlesInNSTableView
//
//  Created by JC Nolan on 9/18/21.
//

import Cocoa

class SentenceTableTitleRowCellView: NSTableCellView {
    
    var twiddleIsOpen = false
    
    @IBOutlet var twiddleImage: NSImageView!
    
    @IBAction func onTwiddleClicked(_ sender: Any) {
        print("twiddle")
        twiddleIsOpen = !twiddleIsOpen
        twiddleImage.image = twiddleIsOpen ? NSImage(imageLiteralResourceName: "favpng_triangle-arrow right")
                                           : NSImage(imageLiteralResourceName: "favpng_triangle-arrow down")
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
