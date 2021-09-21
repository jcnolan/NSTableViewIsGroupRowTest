//
//  KosTextDecoration.swift
//  WKID
//
//  Created by Beckertalk67 on 4/24/17.
//  Copyright © 2017 Warnock-Becker. All rights reserved.
//

import Cocoa

class KosTextDecoration {
    
    static func getAlignedTerm( myTerm: NSMutableAttributedString, myAlignment: NSTextAlignment ) -> NSMutableAttributedString {
        
        let retVal = myTerm
        
        let style = NSMutableParagraphStyle()
        style.alignment = myAlignment
        retVal.addAttribute(.paragraphStyle, value: style, range: NSMakeRange(0, myTerm.length))
        
        return retVal
    }
    
    static func getShrunkenTerm( myTerm: NSMutableAttributedString, size: CGFloat=9.0 ) -> NSMutableAttributedString {
        
        let retVal = myTerm
        
        retVal.addAttribute(NSAttributedString.Key.font, value: NSFont(name: "Avenir-Heavy", size: size)!, range: NSMakeRange(0, myTerm.length))
        return retVal
    }
    
    static func getBoldedTerm( myTerm: NSMutableAttributedString ) -> NSMutableAttributedString {
        
        let retVal = myTerm
        
        retVal.addAttribute(NSAttributedString.Key.font, value: boldFont13, range: NSMakeRange(0, myTerm.length))
        
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = 19
        retVal.addAttribute(.paragraphStyle, value: style, range: NSMakeRange(0, myTerm.length))
        
        return retVal
    }
    
    static func getColoredTerm( myTerm: NSMutableAttributedString, myColor:NSColor=NSColor.white ) -> NSMutableAttributedString {
        
        var retVal = myTerm
        
        retVal.addAttribute(NSAttributedString.Key.foregroundColor, value:myColor, range: NSMakeRange(0, myTerm.length))
        
        return retVal
    }
    
    static func sized(_ text: String, fontSize:CGFloat=13.0) -> NSMutableAttributedString {
        
        return KosTextDecoration.sized(NSMutableAttributedString(string:text), fontSize:fontSize)
    }
    
    static func sized(_ nsmText: NSMutableAttributedString, fontSize:CGFloat=13.0) -> NSMutableAttributedString {
        
        let newText = NSMutableAttributedString( attributedString: nsmText)
        var attributes = [NSAttributedString.Key: Any]()
        attributes[NSAttributedString.Key.font] = NSFont.systemFont(ofSize: fontSize)
        
        newText.addAttributes(attributes, range: NSRange(location: 0, length: newText.length))
        return newText
    }
    
    static func system(_ text: String, fontSize:CGFloat=13.0) -> NSMutableAttributedString {
        
        return KosTextDecoration.system(NSMutableAttributedString(string:text), fontSize:fontSize)
    }

    static func system(_ nsmText: NSAttributedString, fontSize:CGFloat=13.0) -> NSAttributedString {
        
        var mutable = NSMutableAttributedString(attributedString: nsmText)
        mutable = KosTextDecoration.system(mutable)
        
        let retVal = NSAttributedString(attributedString: mutable)
        return retVal
    }
    
    static func system(_ nsmText: NSMutableAttributedString, fontSize:CGFloat=13.0) -> NSMutableAttributedString {
        
        let newText = NSMutableAttributedString( attributedString: nsmText)
        var attributes = [NSAttributedString.Key: Any]()
        attributes[NSAttributedString.Key.font] = NSFont.systemFont(ofSize: fontSize)
        
        newText.addAttributes(attributes, range: NSRange(location: 0, length: newText.length))
        return newText
    }
    
    static func bold(_ text: String, fontSize:CGFloat=13.0) -> NSMutableAttributedString {
        
        return KosTextDecoration.bold(NSMutableAttributedString(string:text), fontSize:fontSize)
    }

    static func bold(_ nsmText: NSAttributedString, fontSize:CGFloat=13.0) -> NSAttributedString {
        
        var mutable = NSMutableAttributedString(attributedString: nsmText)
        mutable = KosTextDecoration.bold(mutable)
        
        let retVal = NSAttributedString(attributedString: mutable)
        return retVal
    }
    
    static func bold(_ nsmText: NSMutableAttributedString, fontSize:CGFloat=13.0) -> NSMutableAttributedString {
        
        let newText = NSMutableAttributedString( attributedString: nsmText)
        var attributes = [NSAttributedString.Key: Any]()
        attributes[NSAttributedString.Key.font] = NSFont.boldSystemFont(ofSize: fontSize)
        
        newText.addAttributes(attributes, range: NSRange(location: 0, length: newText.length))
        return newText
    }

    static func italic(_ text: String, fontSize:CGFloat=13.0) -> NSMutableAttributedString {
        
        return KosTextDecoration.italic(NSMutableAttributedString(string:text), fontSize:fontSize)
    }

    static func italic(_ nsmText: NSMutableAttributedString, fontSize:CGFloat=13.0) -> NSMutableAttributedString {
        
        let newText = NSMutableAttributedString( attributedString: nsmText)
        var attributes = [NSAttributedString.Key: Any]()
        attributes[NSAttributedString.Key.font] = NSFont(name: "Verdana-Italic", size: fontSize)!
        
        newText.addAttributes(attributes, range: NSRange(location: 0, length: newText.length))
        return newText
    }
    
    static func colored(_ text: String, foreground: NSColor? = nil, background: NSColor? = nil) -> NSMutableAttributedString
    {
        var attributes = [NSAttributedString.Key: Any]()
        
        if let foreground = foreground {
            attributes[NSAttributedString.Key.foregroundColor] = foreground
        }
        
        if let background = background {
            attributes[NSAttributedString.Key.backgroundColor] = background
        }
        
        return NSMutableAttributedString (string: text, attributes: attributes)
    }
    
    static func colored(_ nsmText: NSMutableAttributedString, foreground: NSColor? = nil, background: NSColor? = nil) -> NSMutableAttributedString {
        
        let newText = NSMutableAttributedString( attributedString: nsmText)
        var attributes = [NSAttributedString.Key: Any]()
        
        if let foreground = foreground {
            attributes[NSAttributedString.Key.foregroundColor] = foreground
        }
        
        if let background = background {
            attributes[NSAttributedString.Key.backgroundColor] = background
        }
        newText.addAttributes(attributes, range: NSRange(location: 0, length: newText.length))
        return newText
    }
/* archaic?  Moved to the FA helper?
     
    static func fa(_ text: NSMutableAttributedString) -> NSMutableAttributedString {
    
        let myAttribute = [ NSAttributedStringKey.font: NSFont(name: "Font Awesome 5 Brands", size: 11.0)! ]
        text.addAttributes(myAttribute, range: NSRange(location: 0, length: text.length))
        
        return text
    }
  */
    static func convertToNSMutableAttributedString(_ text: Any) -> NSMutableAttributedString? {
        var convertedText: NSMutableAttributedString?
        switch text {
        case let stringText as String: convertedText = NSMutableAttributedString(string: stringText)
        case let attributedStringText as NSAttributedString: convertedText = NSMutableAttributedString(attributedString: attributedStringText)
        case let mutableAttributedStringText as NSMutableAttributedString: convertedText = mutableAttributedStringText
        default: break // Could not convert text
        }
        return convertedText
    }
    
    static func truncate(_ text: String, to length: Int) -> String {
        var truncatedText = text
        if truncatedText.count > length {
            let index = truncatedText.index(truncatedText.startIndex, offsetBy: length)
            truncatedText = truncatedText.substring(to: index)
            truncatedText += " …"
        }
        return truncatedText
    }

    static func trimNewLines(_ attributedString: NSAttributedString) -> NSMutableAttributedString {
        var trimmedString = NSMutableAttributedString(attributedString: attributedString)

        while trimmedString.string.hasSuffix("\n") {
            trimmedString = trimmedString.attributedSubstring(from: NSMakeRange(0, trimmedString.length - 1)) as! NSMutableAttributedString
        }

        while trimmedString.string.hasPrefix("\n") {
            trimmedString = trimmedString.attributedSubstring(from: NSMakeRange(1, trimmedString.length)) as! NSMutableAttributedString
        }

        return trimmedString
    }
}
