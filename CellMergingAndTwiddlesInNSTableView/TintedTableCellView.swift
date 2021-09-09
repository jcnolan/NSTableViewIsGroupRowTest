//
//  TintedTableRow.swift
//  CellMergingAndTwiddlesInNSTableView
//
//  Created by JC Nolan on 9/9/21.
//

import Cocoa

class TintedTableCellView: NSTableCellView {
    
 //   @IBOutlet var contentView: TintedTableCellView!
    @IBOutlet var twiddle: NSTextField!
    @IBOutlet var title: NSTextField!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        
        // standard initialization logic
        // let nib = Bundle.main.loadNibNamed("TintedTableRow", owner: self, topLevelObjects: nil)
    //    let nib = NSNib(nibNamed: "TintedTableRowView", bundle: nil)
    //    nib?.instantiate(withOwner: self, topLevelObjects: nil)
   //     contentView.frame = bounds
   //     addSubview(contentView)
        
        // custom initialization logic
    }
}

