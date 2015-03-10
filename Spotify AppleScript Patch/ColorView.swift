//
//  ColorView.swift
//  Spotify AppleScript Patch
//
//  Created by Boy van Amstel on 10/03/15.
//  Copyright (c) 2015 Danger Cove. All rights reserved.
//

import Cocoa

@IBDesignable
class ColorView: NSView {
    
    @IBInspectable var backgroundColor: NSColor?

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        if((self.backgroundColor) != nil) {
            self.backgroundColor!.setFill()
            NSRectFill(dirtyRect)
        }

    }
}