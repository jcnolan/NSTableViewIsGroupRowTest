//
//  ViewController.swift
//  CellMergingAndTwiddlesInNSTableView
//
//  Created by JC Nolan on 9/9/21.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var tableView: NSTableView!
    
    @IBOutlet var links: NSTextField!
    @IBOutlet var console: NSTextField!
    
    @IBAction func onTest(_ sender: Any) {
        
        links.attributedStringValue = NSAttributedString(string: "Hello world...")
        
        let myTermFreqs: PidsByTerm = [
            "exception":["3.1573-3.1582,148.24200000000002,147.9014,47.81,11.169999999999987"],
            "format":["2.1456-2.1461,196.74200000000002,434.9062,27.777999999999963,11.170000000000016",
                      "2.2062-2.2067,127.80799999999999,217.0019,60.21039999999999,11.169999999999987",
                      "3.403-3.408,118.36999999999999,553.2928,31.11400000000002,11.169999999999959",
                      "3.923-3.928,152.23041,275.9014,28.342000000000013,11.170000000000016",
                      "5.1455-5.1461,196.03200000000004,428.2498,27.787999999999982,10.0",
                      "9.643-9.649,290.6764,639.6557,31.802999999999884,10.0"],
            "society":[
                "0.145-0.151,473.5119999999999,639.2763,31.124000000000024,11.169999999999959",
                "1.1634-1.1640,257.84800000000007,393.0007,30.382000000000005,11.170000000000016",
                "1.1765-1.1771,374.60600000000005,381.467,31.124000000000024,11.170000000000016",
                "1.1937-1.1943,211.71200000000005,358.3997,31.124000000000024,11.170000000000016",
                "5.367-5.373,179.76,610.6498,30.496000000000066,10.0"],
            "base":[
                "2.1769-2.1773,415.2020000000003,400.3053,24.464,11.170000000000016",
                "9.2695-9.2699,228.41200000000006,162.9561,18.904000000000025,10.0",
                "10.1243-10.1247,101.68200000000002,559.7501000000001,23.244,10.0"
            ],
            "air":["1.2518-1.2520,215.13099999999997,314.3324,11.114000000000033,11.170000000000016"],
            "order":[
                "4.481-4.485,400.4720000000002,672.4763,23.345999999999947,11.169999999999959",
                "6.1276-6.1280,120.57400000000001,403.96410000000003,22.793999999999983,10.0",
                "8.2843-8.2847,138.434,106.39500000000001,21.840000000000003,10.0"
            ]
        ]
        let mySearchTermFreqs: PidsByTerm? = nil
        
        let myDensSeeItem = DensSeeTermHelper.getDensSeeItemForFreqs(myTermFreqsForPage: myTermFreqs, mySearchTermFreqsForPage: mySearchTermFreqs)
        
        links.attributedStringValue = myDensSeeItem.freqStr
    }
    
    @IBAction func onExit(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }

    /// --------------------
    
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

