//
//  TableViewTermClickHandler.swift
//  CellMergingAndTwiddlesInNSTableView
//
//  Created by JC Nolan on 9/21/21.
//

import Cocoa

extension CMTViewController {
    
    private static var _lastTermClicked = [String:String]()
    var lastTermClicked: String {
        get    { return CMTViewController._lastTermClicked[String(format: "%p", unsafeBitCast(self, to: Int.self))] ?? "" }
        set(newValue) { CMTViewController._lastTermClicked[String(format: "%p", unsafeBitCast(self, to: Int.self))] = newValue }
    }
    
    private static var _lastClickTime = [String:Date]()
    var lastClickTime: Date {
        get    { return CMTViewController._lastClickTime[String(format: "%p", unsafeBitCast(self, to: Int.self))] ?? Date() }
        set(newValue) { CMTViewController._lastClickTime[String(format: "%p", unsafeBitCast(self, to: Int.self))] = newValue }
    }

    private static var _controlActive = [String:Bool]()
    var controlActive: Bool {
        get    { return CMTViewController._controlActive[String(format: "%p", unsafeBitCast(self, to: Int.self))] ?? Bool() }
        set(newValue) { CMTViewController._controlActive[String(format: "%p", unsafeBitCast(self, to: Int.self))] = newValue }
    }
    
    func attachSentenceTableRigging() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.target = self
        tableView.action = #selector(densSeeSentenceTableViewClick(_:))
        tableView.doubleAction = #selector(densSeeSentenceTableViewDoubleClick(_:))
    }
    
    func determineSelectedBaseTerms() -> [String] {
        return []
    }
    
    ///////
    
    // Note: todo - WISH these two were in the TermDataSentenceTableView protocol but objc not allowed in protocols (or it caused whack-a-mole)
   
   @objc func densSeeSentenceTableViewClick(_ sender: AnyObject) {
       let myTableView: NSTableView = sender as! NSTableView
       let selectedBaseTerms = determineSelectedBaseTerms()
       termDataSentenceClicked(rowNum: myTableView.clickedRow, controlFlag: controlActive, selectedTerms: selectedBaseTerms)
   }
   
   @objc func densSeeSentenceTableViewDoubleClick(_ sender: AnyObject) {
       let myTableView: NSTableView = sender as! NSTableView
       let selectedBaseTerms = determineSelectedBaseTerms()
       termDataSentenceClicked(rowNum: myTableView.clickedRow, controlFlag: true, selectedTerms: selectedBaseTerms)
   }

    
    @objc func densSeeTableViewClick(_ sender: AnyObject){
        let myTableView: NSTableView = sender as! NSTableView
        let tableId = myTableView.identifier!.rawValue
        densSeeTermClicked(tableId: tableId, rowNum: myTableView.clickedRow)
    }
    
    @objc func densSeeTableViewDoubleClick(_ sender: AnyObject) {
        let myTableView: NSTableView = sender as! NSTableView
        let tableId = myTableView.identifier!.rawValue
        densSeeTermClicked(tableId: tableId, rowNum: myTableView.clickedRow, doubleFlag: true)
    }
    
    func densSeeTermClicked(tableId: String, rowNum: Int, doubleFlag: Bool = false) {
        switch tableId {
        case "TermTableBase"    : baseTermClicked(rowNum: rowNum, doubleFlag: doubleFlag)
        default: break
        }
    }
    
    func termDataSentenceClicked(rowNum: Int, controlFlag: Bool = false, selectedTerms: [String]? = nil)
    {
        print("termDataSentenceClicked: row = \(rowNum)")
     
        /*
        guard (rowNum >= 0) && (rowNum < termDataSentences.count) else { return }
        
        var openInNewWindow:  Bool

        if let workspaceType = workspace.options[KosWorkspaceOption.type] as? KosWorkspaceType,
            workspaceType == KosWorkspaceType.document {
            openInNewWindow = controlFlag
        } else {
            openInNewWindow = KosPreferenceManager.shared.alwaysOpenDocumentInNewWindow!
            if controlFlag {
                openInNewWindow = !openInNewWindow
            }
        }
        
        if openInNewWindow {
            nh.openDocumentInNewWindow(for: termDataSentences[rowNum], selectedTerms: selectedTerms)
        } else {
            nh.openDocumentWithinWindow(for: termDataSentences[rowNum], selectedTerms: selectedTerms)
        }
 */
    }
    
    func baseTermClicked(rowNum:Int, doubleFlag:Bool) {
        
        print("baseTermClicked: row = \(rowNum)")
        
        /*
        guard (rowNum >= 0) && (rowNum < dataState.densSeeDataItems.count) else { return }
        
        var openInNewWindow = KosPreferenceManager.shared.alwaysOpenDocumentInNewWindow!
        if doubleFlag {
            openInNewWindow = !openInNewWindow
        }

        let selectedTerms: [String] = controlState.searchText.components(separatedBy: ",")
        if openInNewWindow {
            nh.openDocumentInNewWindow(for: dataState.densSeeDataItems[rowNum]!, selectedTerms: selectedTerms)
        } else {
            nh.openDocumentWithinWindow(for: dataState.densSeeDataItems[rowNum]!, selectedTerms: selectedTerms)
        }
 */
    }
    
    func clickSubPhrase(in textView: TermTextView, event: NSEvent, row: Int?)->String? {
        
        // Note: This may be an artifact out of TermSee... this is the main handler for clicking on a "term" though name is unfortunate
        
        print("Click Sub Phrase")

        print("Row clicked: \(row)")
        
        let clickLocationInApp = event.locationInWindow
        print("Click Location in app: \(clickLocationInApp)")
        
        let clickLocationInTextView = self.view.window?.contentView?.convert(clickLocationInApp, to: textView)
        print("Click Location in TermTextView: \(clickLocationInTextView)")
        
        let index = textView.characterIndexForInsertion(at: clickLocationInTextView!)
        print("Character index: \(index)")
        
        let text = textView.textStorage as! NSAttributedString
        let textAsString = text.string
        
        var found = false
        var tterm:String? = nil
        
        if index < text.string.count {

            let attribute = text.attribute(KosLinkedTermAttributeKey, at: index, effectiveRange: nil)
            if let term = attribute as? String {

                // ATTRIBUTE HANDLING LOGIC GOES HERE:
                print("term: \(term)")
                
                // var stackToggleTerms: Bool = event.modifierFlags.intersection(.deviceIndependentFlagsMask) == [.shift] // Stack only with shift
                var stackToggleTerms = true   // Stack no matter what
                
                let currentClickTime = Date()
                if currentClickTime.adding(seconds: -1) < lastClickTime && term == lastTermClicked {
                    // simulated double click
                    stackToggleTerms = false
                }
                print("ShiftIsActive: \(stackToggleTerms)")
                
                var currentSearchValsSet: Set<String> = Set()
         /*
                if stackToggleTerms == true {
                
                    for currentSearchVal in controlState.searchText.components(separatedBy: ",") {
                        if currentSearchVal != "" { currentSearchValsSet.insert(currentSearchVal.trimmingCharacters(in: .whitespacesAndNewlines)) }
                    }
                }
            */
                if currentSearchValsSet.contains(term) { currentSearchValsSet.remove(term) }
                else                                   { currentSearchValsSet.insert(term) }
                
                let newSearchString:String = currentSearchValsSet.joined(separator: ",")
                console.stringValue = newSearchString
                
               // searchFieldUpdated(console.stringValue)
                lastClickTime = Date()
                lastTermClicked = term
                tterm = term
                found = true
            }
        }
        if !found {
            // We clicked off a term, act as if row select was done
          //  previewSelectedTermTableViewRow(row:row)
            print("clicked off row")
        }
        return tterm
    }
}
