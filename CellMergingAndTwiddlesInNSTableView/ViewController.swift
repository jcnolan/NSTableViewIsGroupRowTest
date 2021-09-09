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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        tableView.delegate = self
        tableView.dataSource = self
        
        installStubData()
        tableView.reloadData()
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

