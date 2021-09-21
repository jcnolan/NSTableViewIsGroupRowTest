//
//  DensSeeTermHelper.swift
//  CellMergingAndTwiddlesInNSTableView
//
//  Created by JC Nolan on 9/21/21.
//

import Cocoa

typealias PidsByTerm        = [String:[String]]

class DensSeeTermHelper {
    
    struct DensSeeItem {
        
        var freqStr:    NSMutableAttributedString = NSMutableAttributedString(string:"")
        var freq:       Int = 0
        var searchFreq: Int = 0
        var terms:      [String:[PidsByTerm]] = [:]
        var pageStart:  Int = 0
        var pageEnd:    Int = 0
        var searchTermFound: Bool = false
        var constrainBySearch: Bool = false // Note, this may be a waste... but saving it just in case it's helpful some day (not likely)
    }
    
    static func getDensSeeItemForFreqs(
        myTermFreqsForPage         : PidsByTerm,
        mySearchTermFreqsForPage   : PidsByTerm?,
        sPageNum                   : Int = -1,
        ePageNum                   : Int = -1
    ) -> DensSeeItem {
        
        var myTermFreqsStr:NSMutableAttributedString = getCSSStyleString()
        
        var myDensSeeItem: DensSeeItem = DensSeeItem()
        var myDensSeeItemFreqs:Int = 0
        var myDensSeeSearchItemFreqs:Int = 0
        
        myDensSeeItem.searchTermFound = false
//        myDensSeeItem.constrainBySearch = (controlState.showAllTerms != true && controlState.searchText != "") - put this back in! (When moved to WKID)
        
        //////
        
        var doCSS: Bool { get { return false } }
        // let doCSS = false
        
        func getCSSStyleString()->NSMutableAttributedString
        {
            var myStyleStr = NSMutableAttributedString(string:"")
            
            if doCSS
            {
                let style:String =
                    """
                <style>.caption {color : #666; font-size: 12px; font-family: -apple-system, system-ui; font-style: italic; text-align: right;} \
                .chicklet3 {background: #CDCDCD; border-radius: 0.25em;} \
                .chicklet { \
                    background-color: #CDCDCD; /* Changing background color */
                    border-radius: .5em; /* Making border radius */
                    padding: .16em .65em .16em .65em; /* Making space around letters */
                }
                .chicklet2 {
                    background-color: gray; /* Changing background color */
                    font-weight: bold; /* Making font bold */
                    border-radius: 20px; /* Making border radius */
                    width: auto; /* Making auto-sizable width */
                    height: auto; /* Making auto-sizable height */
                    padding: 5px 30px 5px 30px; /* Making space around letters */
                    font-size: 18px; /* Changing font size */
                }</style>
                """
                
                myStyleStr = try! NSMutableAttributedString(
                    data: Data(style.utf8),
                    options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                    documentAttributes: nil)
            }
            
            return myStyleStr
        }
        
        // Sort the terms by frequency
        
        let mySortedFreqsPerPage = myTermFreqsForPage.sorted(by: {
            // Sort by descend frequency / ascend term
            return ($0.value.count != $1.value.count) ? ($0.value.count > $1.value.count) : ($0.key < $1.key)
        })
        
        let searchActive = mySearchTermFreqsForPage != nil
        
        for (myTerm, myFreqs) in mySortedFreqsPerPage {
            
            //      Build a string from those terms
            
            var myMAStr = !doCSS ? NSMutableAttributedString(string:"\(myTerm) (\(myFreqs.count)), ")
                : NSMutableAttributedString(string:"\(myTerm) <span class='chicklet2'>&nbsp;(\(myFreqs.count)) </span>, ")
            
            if searchActive {
                if let _ = mySearchTermFreqsForPage![myTerm] {
                    
                    myMAStr = KosTextDecoration.getBoldedTerm( myTerm: myMAStr )
                    myDensSeeSearchItemFreqs = myDensSeeSearchItemFreqs + mySearchTermFreqsForPage![myTerm]!.count
                    myDensSeeItem.searchTermFound = true
                } else {
                    if (myDensSeeItem.constrainBySearch) { myMAStr = NSMutableAttributedString(string:"") }
                    else                                 { myMAStr = KosTextDecoration.colored(myMAStr, foreground: NSColor.systemGray, background: NSColor.clear) }
                }
            }
            
            myMAStr.addAttributes([KosLinkedTermAttributeKey: myTerm], range: NSMakeRange(0, myMAStr.string.count))
            
            myTermFreqsStr.append(myMAStr)
            
            myDensSeeItemFreqs = myDensSeeItemFreqs + myFreqs.count
            
            if ( myDensSeeItem.terms[myTerm] == nil ) {
                myDensSeeItem.terms[myTerm] = []
            }
        }
        
        if doCSS
        {
            // Add stylesheet to string
            let style:String =
                """
            <style>.caption {color : #666; font-size: 12px; font-family: -apple-system, system-ui; font-style: italic; text-align: right;} \
            .chicklet2 {background: #CDCDCD; border-radius: 0.25em;} \
            .chicklet { \
                background-color: #CDCDCD; /* Changing background color */
                border-radius: 1em; /* Making border radius */
                padding: .16em .65em .16em .65em; /* Making space around letters */
            } </style>
            """
            
            let fasdf:String = style + myTermFreqsStr.string
            //    let myTermFreqsStrSave = myTermFreqsStr
            
            myTermFreqsStr = try! NSMutableAttributedString(
                data: Data(fasdf.utf8),
                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
            
            //     myTermFreqsStr.append(myTermFreqsStrSave)
            
            print(myTermFreqsStr)
            print(myTermFreqsStr.string)
            
        } else {}
        
        
        if (myDensSeeItem.constrainBySearch == true) {myDensSeeItemFreqs = myDensSeeSearchItemFreqs}
        else if myDensSeeItem.searchTermFound == true {myDensSeeItem.searchFreq = myDensSeeSearchItemFreqs}
        
        myDensSeeItem.freqStr   = myTermFreqsStr
        myDensSeeItem.freq      = myDensSeeItemFreqs
        myDensSeeItem.pageStart = sPageNum
        myDensSeeItem.pageEnd   = ePageNum
        
        return myDensSeeItem
    }
}
