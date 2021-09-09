//
//  TintedTableRow.swift
//  CellMergingAndTwiddlesInNSTableView
//
//  Created by JC Nolan on 9/9/21.
//

import Cocoa

class TintedTableRowView: NSTableRowView {
    
    var isTitleRow:  Bool = false
    
    override func draw(_ dirtyRect: NSRect) {
       
        if self.selectionHighlightStyle != .none || true {
            
            var bgcol:NSColor = NSColor.clear
            
            switch isTitleRow {
            case true: bgcol = NSColor.lightGray
            default:   bgcol = NSColor.clear }
            
            let selectionRect = NSInsetRect(self.bounds, 0, 0)
            bgcol.setStroke()
            bgcol.setFill()
            let selectionPath = NSBezierPath.init(roundedRect: selectionRect, xRadius: 0, yRadius: 0)
            selectionPath.fill()
            selectionPath.stroke()
        }
    }
}
