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
    case termsCell   = "termsCol"
    case titleRow    = "titleRow"

    var isTitleRow: Bool { get { return self == .titleRow } }
    
    var uiiId: NSUserInterfaceItemIdentifier {
        get { switch self {
        case .titleRow : return NSUserInterfaceItemIdentifier(CellIdentifiers.pageCell.rawValue) // On group row, we return the first cell
        default        : return NSUserInterfaceItemIdentifier(self.rawValue)                     // Otherwise, return associated cell
        }}}
}

extension CMTViewController: NSTableViewDelegate {
   
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
        else                             { cellIdentifier = CellIdentifiers.titleRow } // When "groupRow" is true there is no column, so use first column whatever that is

        if let _ = item.title { cellIdentifier = CellIdentifiers.titleRow } // hack
        
        guard let cellIdentifier = cellIdentifier else { return nil }
        
        print("Cell identifier: \(cellIdentifier)")
    
        if var cell = tableView.makeView(withIdentifier: cellIdentifier.uiiId, owner: nil) as? NSTableCellView {
            
            switch cellIdentifier {
            
            case .pageCell:     text = item.page?.description ?? "page unk"; break
            case .commentCell:  text = item.comment ?? "comment unk"; break
            case .termsCell:    aText = myDensSeeItem?.freqStr; break
            case .titleRow:     text = item.title ?? "title unk"
                var attributes = [NSAttributedString.Key: AnyObject]()
                attributes[.foregroundColor] = NSColor.white
                attributes[.font] = NSFont.boldSystemFont(ofSize: 13.0)
                aText = NSAttributedString(string: text, attributes: attributes)
                
                // https://stackoverflow.com/questions/53868435/how-to-create-a-custom-nstablecellview-from-a-nib
                if let rowCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("TintedTableCellView"), owner: nil) as? TintedTableCellView
                {
                    rowCell.addHandlers()
                    rowCell.parent = self
                    rowCell.title.attributedStringValue = aText!
           //         cell3.twiddle.stringValue = "▼"
                    cell = rowCell
                }
            }
            
            if (cellIdentifier == .termsCell), let aText = aText
            {
                if let textViewCell = cell as? TextViewTableCellView {
                    textViewCell.textView.parent = self
                    textViewCell.textView.row = row
                    textViewCell.textView.backgroundColor = NSColor.systemTeal
                    textViewCell.textView.textStorage!.setAttributedString(aText)
                    //textViewCell.textView.textStorage?.setAttributedString(NSAttributedString(string: "hello world..."))
                    if true {
                        var b = textViewCell.textView.frame
                        //                    b.size.width = showSingleRowInTermsTable ? 8000 : densSeePaneBase.bounds.width
                        //          b.size.width = densSeePaneBase.bounds.width
                        b.size.width = 400
                        b.size.width = tableView.bounds.width
                //        textViewCell.textView.frame = b
                    }
                    cell = textViewCell
                }
                
            } else {
            
                if let aText = aText { cell.textField?.attributedStringValue = aText }
                else                 { cell.textField?.stringValue = text }
            }
            return cell
        }
        return nil
    }
    
}
