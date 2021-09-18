//
//  TintedTableRow.swift
//  CellMergingAndTwiddlesInNSTableView
//
//  Created by JC Nolan on 9/9/21.
//

import Cocoa

class TintedTableCellView: NSTableCellView {
    
 //   @IBOutlet var contentView: TintedTableCellView!
    @IBOutlet var twiddle: NSImageView!
    @IBOutlet var title: NSTextField!
    
    @IBAction func twiddleAction(_ sender: Any) {
        print("twiddle")
    }
    @IBAction func titleAction(_ sender: Any) {
        print("title")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
      //  addHandlers()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     //   initSubviews()
        addHandlers()
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
    
    func addHandlers() {
        
        // Add double click handler for control bar.
        
        let gesture = NSClickGestureRecognizer()
        gesture.buttonMask = 0x1 // left mouse
        gesture.numberOfClicksRequired = 1
        gesture.target = self
        gesture.action = #selector(clickControlBar(_:))
        
        self.twiddle.addGestureRecognizer(gesture)
        self.title.addGestureRecognizer(gesture)
    }
    
    @IBAction func clickControlBar(_ sender: Any) {
        //toggleState()
       print("click")
    }
}
