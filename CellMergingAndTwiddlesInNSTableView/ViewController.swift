//
//  ViewController.swift
//  CellMergingAndTwiddlesInNSTableView
//
//  Created by JC Nolan on 9/9/21.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var tableView: NSTableView!
    
    @IBAction func onExit(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }

    var tableData: [TableDataItem]? = nil
    
    lazy var window: NSWindow = self.view.window!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        tableView.delegate = self
        tableView.dataSource = self
        tableView.floatsGroupRows = false
        
        let customCellNib = NSNib.init(nibNamed: "TintedTableCellView", bundle: nil)
        tableView.register(customCellNib, forIdentifier: NSUserInterfaceItemIdentifier("TintedTableCellView"))
                
        tableView.target = self
        tableView.action = #selector(onItemClicked)
        
        installStubData()
        tableView.reloadData()
    }
    
    @objc private func onItemClicked()
    {
        print("row \(tableView.clickedRow), col \(tableView.clickedColumn) clicked")
        let clickLocation = window.mouseLocationOutsideOfEventStream
        print("clickLocation: \(clickLocation)")
        
        if tableView.clickedColumn == -1 {
            if let tableRowView = tableView.view(atColumn: 0, row: tableView.clickedRow, makeIfNecessary: false) as? TintedTableCellView {
                let twiddleViewBounds = tableRowView.twiddle.bounds
//                print("Bounds: \(twiddleViewBounds)")
                let clickLocInTwiddle = self.view.convert(clickLocation, to: tableRowView.twiddle)
                print("clickLocInTwiddle: \(clickLocInTwiddle)")
                let twiddleBoundsRelativeToRow = tableRowView.twiddle.convert(twiddleViewBounds, to: tableRowView)
                print("twiddleBoundsRelativeToRow: \(twiddleBoundsRelativeToRow)")
       
                if clickLocInTwiddle.x >= 0,
                   clickLocInTwiddle.x <= twiddleViewBounds.width,
                   clickLocInTwiddle.y >= 0,
                   clickLocInTwiddle.y <= twiddleViewBounds.height {
                    print("In \(tableView.clickedRow)")
                    
                    tableRowView.twiddleOpen = !tableRowView.twiddleOpen
                    if tableRowView.twiddleOpen {tableRowView.twiddle.image = NSImage(imageLiteralResourceName: "favpng_triangle-arrow-down-white")}
                    else                        {tableRowView.twiddle.image = NSImage(imageLiteralResourceName: "favpng_triangle-arrow-right-white")}
                    
                } else {
                    print("Out \(tableView.clickedRow)")
                }
            }
        }
    }
    
    func installStubData() {
        
        tableData = []
        tableData!.append(TableDataItem(title: "This is doc title 1", page: nil, comment: nil))
        tableData!.append(TableDataItem(title: nil, page: 1, comment: "this is doc 1, page one comment"))
        tableData!.append(TableDataItem(title: nil, page: 2, comment: "this is doc 1, page two comment"))
        tableData!.append(TableDataItem(title: nil, page: 3, comment: "this is doc 1, page three comment"))
        tableData!.append(TableDataItem(title: "This is doc title 2", page: nil, comment: nil))
        tableData!.append(TableDataItem(title: nil, page: 1, comment: "this is doc 2, page one comment"))
        tableData!.append(TableDataItem(title: "This is doc title 3", page: nil, comment: nil))
        tableData!.append(TableDataItem(title: nil, page: 1, comment: "this is doc 3, page one comment"))
        tableData!.append(TableDataItem(title: nil, page: 2, comment: "this is doc 3, page two comment"))
    }

}

