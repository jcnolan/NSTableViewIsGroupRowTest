//
//  KosAnnotationScrollView.swift
//  WKID
//
//  Created by Beckertalk67 on 8/3/17.
//  Copyright © 2017 Warnock-Becker. All rights reserved.
//

import Cocoa

class KosAnnotationScrollView: NSScrollView {
    
    override func scrollWheel(with event: NSEvent) {
        nextResponder?.scrollWheel(with: event)
    }
    
}
