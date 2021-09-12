//
//  TableViewDeligate.swift
//  CellMergingAndTwiddlesInNSTableView
//
//  Created by JC Nolan on 9/9/21.
//

import Cocoa

fileprivate enum CellIdentifiers : String {
    
    case pageCell    = "pageCol"
    case commentCell = "commentCol"
    case titleRow    = "titleRow"

    var isTitleRow: Bool { get { return self == .titleRow } }
    
    var uiiId: NSUserInterfaceItemIdentifier {
        get { switch self {
        case .titleRow : return NSUserInterfaceItemIdentifier(CellIdentifiers.pageCell.rawValue) // On group row, we return the first cell
        default        : return NSUserInterfaceItemIdentifier(self.rawValue)                     // Otherwise, return associated cell
        }}}
}

extension ViewController: NSTableViewDelegate {
   
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        
        // Required for changing table highlighting
        
        guard let item = tableData?[row] else { return nil }
        
        let retVal:TintedTableRowView? = TintedTableRowView()
        
        if let retVal = retVal {
            retVal.isTitleRow = item.title != nil
        }
        
        return retVal
    }
    
    func tableView(_ tableView: NSTableView, isGroupRow row: Int) -> Bool {
        
      //  return false  // Uncomment this to see NSAttributedString working in standard row
        
        guard let item = tableData?[row], let title = item.title else { return false }
        return true // only if item exists and it's a tittle
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text: String = "Doh!"
        var aText: NSAttributedString? = nil
        var cellIdentifier: CellIdentifiers? = nil
        
        guard let item = tableData?[row] else { return nil }
        
        if let tableColumn = tableColumn { cellIdentifier = CellIdentifiers(rawValue: String(describing: tableColumn.identifier.rawValue)) }
        else                             { cellIdentifier = CellIdentifiers.pageCell } // When "groupRow" is true there is no column, so use first column whatever that is

        if let _ = item.title { cellIdentifier = CellIdentifiers.titleRow } // hack
        
        guard let cellIdentifier = cellIdentifier else { return nil }
        
        if var cell = tableView.makeView(withIdentifier: cellIdentifier.uiiId, owner: nil) as? NSTableCellView {
            
            switch cellIdentifier {
            
            case .pageCell:     text = item.page?.description ?? "page unk"; break
            case .commentCell:  text = item.comment ?? "comment unk"; break
                
            case .titleRow:     text = item.title ?? "title unk"
                var attributes = [NSAttributedString.Key: AnyObject]()
                attributes[.foregroundColor] = NSColor.blue
                attributes[.font] = NSFont.boldSystemFont(ofSize: 13.0)
                aText = NSAttributedString(string: text, attributes: attributes)
                //       let cell2 = TintedTableCellView()
                // https://stackoverflow.com/questions/53868435/how-to-create-a-custom-nstablecellview-from-a-nib
                if let cell3 = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("TintedTableCellView"), owner: nil) as? TintedTableCellView
                {
                    cell3.addHandlers()
                    cell3.title.attributedStringValue = aText!
                    cell3.twiddle.stringValue = "▼"
                    cell = cell3
                }
            }
            
            if let aText = aText { cell.textField?.attributedStringValue = aText }
            else                 { cell.textField?.stringValue = text }
            
            return cell
        }
        return nil
    }
    
}
