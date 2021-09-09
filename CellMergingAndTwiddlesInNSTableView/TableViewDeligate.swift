//
//  TableViewDeligate.swift
//  CellMergingAndTwiddlesInNSTableView
//
//  Created by JC Nolan on 9/9/21.
//

import Cocoa

extension ViewController: NSTableViewDelegate {
    
    fileprivate enum CellIdentifiers : String {
        
        case pageCell    = "pageCol"
        case commentCell = "commentCol"
        case titleRow    = "titleRow"
        case none        = ""
        
        init(id: String) {
            switch id {
            case "pageCol"    : self = .pageCell
            case "commentCol" : self = .commentCell
            default           : self = .none
            }
        }
        
        var uiiId: NSUserInterfaceItemIdentifier {
            get { switch self {
            case .titleRow : return NSUserInterfaceItemIdentifier(CellIdentifiers.pageCell.rawValue)
            default        : return NSUserInterfaceItemIdentifier(self.rawValue)
            }}}
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text: String = "Doh!"
        var aText: NSMutableAttributedString? = nil
        var cellIdentifier: CellIdentifiers? = nil
        
        guard let item = tableData?[row] else { return nil }
        
        if let tableColumn = tableColumn { cellIdentifier = CellIdentifiers.init(id: tableColumn.identifier.rawValue) }
        else                             { cellIdentifier = CellIdentifiers.pageCell } // When "groupRow" is true there is no column, so use first column whatever that is

        guard let cellIdentifier = cellIdentifier else { return nil }
        
        if let cell:NSTableCellView = tableView.makeView(withIdentifier: cellIdentifier.uiiId, owner: nil) as? NSTableCellView {
            
            switch cellIdentifier {
            case .pageCell: text = item.page?.description ?? "page unk"
            case .commentCell: text = item.comment ?? "comment unk"
            case .titleRow: text = item.title ?? "title unk"
            default: text = "should never happen"
            }
            
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
    
}
