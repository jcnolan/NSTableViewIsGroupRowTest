//
//  NSColor.swift
//  WKID
//
//  Created by JC Nolan on 4/15/21.
//  Copyright © 2021 JC Nolan / Lapin Publishing. All rights reserved.
//

import Cocoa
import SwiftUI

extension NSColor {
    
    var isDarkMode: Bool {
        
        get {
            let appleInterfaceStyle: String = UserDefaults.standard.object(forKey: "AppleInterfaceStyle") as? String ?? "foo"
            return appleInterfaceStyle == "Dark"
        }}
    
    var inverted: NSColor {

        get{
            let ciColor:CIColor = CIColor(color: self)!
            let newColor = NSColor(red: 1.0-ciColor.red, green: 1.0-ciColor.green, blue: 1.0-ciColor.blue, alpha: ciColor.alpha)
            return newColor
        }}
    
    var adjusted: NSColor {
        
        get {
            
            // Adjusts color for Dark Mode if needed
            
            if isDarkMode { return inverted }
            else { return self }
        }}
}
